//
//  MeliSearchUITests.swift
//  MeliSearch
//
//  Created by Sebastian Beltran Gonzalez on 1/03/25.
//

import XCTest

final class MeliSearchUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testSearchFieldExists() {
        let searchField = app.textFields["Buscar productos..."]
        XCTAssertTrue(searchField.exists, "El campo de búsqueda no se encuentra en la pantalla")
    }
    func testSearchForProduct() {
        let searchField = app.textFields["Buscar productos..."]
        XCTAssertTrue(searchField.exists, "El campo de búsqueda debería existir")

        searchField.tap()
        searchField.typeText("iPhone")

        let searchButton = app.buttons["Buscar"]
        XCTAssertTrue(searchButton.exists, "El botón de búsqueda debería existir")

        searchButton.tap()
        sleep(3)

        let productCell = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(productCell.waitForExistence(timeout: 10), "Debería aparecer al menos un producto en los resultados")
    }

}
