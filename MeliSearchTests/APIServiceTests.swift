//
//  APIServiceTest.swift
//  MeliSearchTests
//
//  Created by Sebastian Beltran Gonzalez on 28/02/25.
//

import XCTest
@testable import MeliSearch

class APIServiceTests: XCTestCase {
    
    func testFetchProductsSuccess() {
        let expectation = self.expectation(description: "API devuelve productos correctamente")
        
        APIService.shared.fetchProducts(query: "iPhone") { result in
            switch result {
            case .success(let products):
                XCTAssertFalse(products.isEmpty, "La lista de productos no debería estar vacía")
            case .failure(let error):
                XCTFail("La API falló con error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchProductsInvalidQuery() {
        let expectation = self.expectation(description: "API maneja una consulta vacía correctamente")
        
        APIService.shared.fetchProducts(query: "") { result in
            switch result {
            case .success(let products):
                XCTAssertTrue(products.isEmpty, "La respuesta debería ser una lista vacía cuando la consulta es vacía")
            case .failure(let error):
                XCTFail("No debería haber un error, pero ocurrió: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

