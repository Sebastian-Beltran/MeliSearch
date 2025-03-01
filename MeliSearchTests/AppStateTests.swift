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
}
