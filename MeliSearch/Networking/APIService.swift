//
//  APIService.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 27/02/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "https://api.mercadolibre.com/sites/MLA/search?q="

    func fetchProducts(query: String, completion: @escaping (Result<[Product], APIError>) -> Void) {
        let urlString = "\(baseURL)\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse.results))
                }
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }.resume()
    }
}


enum APIError: Error, LocalizedError {
    case invalidURL
    case networkError(String)
    case invalidResponse
    case noData
    case decodingError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL de la API no es válida."
        case .networkError(let message):
            return "Error de red: \(message)"
        case .invalidResponse:
            return "Respuesta inválida del servidor."
        case .noData:
            return "No se recibieron datos."
        case .decodingError(let message):
            return "Error al procesar los datos: \(message)"
        }
    }
}
