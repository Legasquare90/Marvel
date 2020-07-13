//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import XCTest
import Nimble

class MarvelUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.shared.orientation = .portrait
    }

    override func tearDownWithError() throws { }

    func testCellsAppear() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cells = app.collectionViews.cells
        let count = NSPredicate(format: "count > 0")

        expectation(for: count, evaluatedWith: cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        expect(app.collectionViews.cells.count) > 0
    }
    
    func testFilter() throws {
        let app = XCUIApplication()
        app.launch()
                
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText("3-")
        
        expect(app.collectionViews.cells.count) == 1
        
        let cellFiltered = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"3-D Man").element
        expect(cellFiltered.exists) == true
    }
    
    func testNavigationToDetail() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"3-D Man").element.tap()
        let segmentedControl = app.segmentedControls.firstMatch
        expect(segmentedControl.exists) == true
    }
    
    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()
                
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText("Iron")
                
        let cellFiltered = app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Iron Man").element
        let exists = NSPredicate(format: "exists == true")

        expectation(for: exists, evaluatedWith: cellFiltered, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        expect(cellFiltered.exists) == true
    }
    
    func testChangeTableSection() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.firstMatch.tap()
        
        let titleCell = app.tables.cells.staticTexts.firstMatch.label
        app.segmentedControls.buttons["Series"].tap()
        let newTitleCell = app.tables.cells.staticTexts.firstMatch.label

        expect(newTitleCell) != titleCell
    }
    
    func testChangeOrientation() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews.cells.firstMatch.tap()
        
        XCUIDevice.shared.orientation = .landscapeRight
        
        let closeButton = app.buttons["ico close"]
        expect(closeButton.exists) == true
    }

}
