//
//  AppStateTests.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 1/03/25.
//

import XCTest
@testable import MeliSearch

class AppStateTests: XCTestCase {

    func testSearchProductsUpdatesState() {
        let appState = AppState()
        let expectation = self.expectation(description: "El estado se actualiza tras la búsqueda")

        appState.searchProducts(query: "iPhone")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertFalse(appState.searchResults.isEmpty, "Los resultados de búsqueda no deberían estar vacíos")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testSearchProductsHandlesEmptyQuery() {
        let appState = AppState()

        appState.searchProducts(query: "")

        XCTAssertNotNil(appState.errorMessage, "Debe haber un mensaje de error para una consulta vacía")
    }

    func testAddToCart() {
        let appState = AppState()
        let product = Product(id: "MLA123", title: "iPhone 13", price: 1000.0, thumbnail: "https://example.com/image.jpg",
                              condition: "new", permalink: "https://example.com/product",
                              originalPrice: 1200.0
        )

        XCTAssertTrue(appState.cart.isEmpty, "El carrito debería estar vacío al inicio")

        appState.addProductCart(product: product)

        XCTAssertEqual(appState.cart.count, 1, "El carrito debería contener un producto después de agregarlo")
        XCTAssertEqual(appState.cart.first?.id, product.id, "El producto en el carrito debería ser el mismo que agregamos")
    }

    func testRemoveFromCart() {
        let appState = AppState()
        let product = Product(id: "MLA123", title: "iPhone 13", price: 1000.0, thumbnail: "https://example.com/image.jpg",
                              condition: "new", permalink: "https://example.com/product",
                              originalPrice: 1200.0
        )

        appState.addProductCart(product: product)
        XCTAssertEqual(appState.cart.count, 1, "El carrito debería contener un producto antes de eliminarlo")

        appState.removeProductCart(product: product)

        XCTAssertTrue(appState.cart.isEmpty, "El carrito debería estar vacío después de eliminar el producto")
    }

}
