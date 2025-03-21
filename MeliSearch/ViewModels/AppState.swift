import Foundation

class AppState: ObservableObject {
    @Published var searchResults: [Product] = []
    @Published var cart: [Product] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func searchProducts(query: String) {
        guard !query.isEmpty else {
            errorMessage = "Por favor, ingresa un término de búsqueda."
            return
        }

        isLoading = true
        errorMessage = nil

        APIService.shared.fetchProducts(query: query) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let products):
                    if products.isEmpty {
                        self.errorMessage = "No se encontraron resultados para \"\(query)\"."
                    }
                    self.searchResults = products
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    func addProductCart(product: Product) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.cart.append(product)
            }
        }
    }
    
    func removeProductCart(product: Product) {
        cart.removeAll { $0.id == product.id }
    }
}
