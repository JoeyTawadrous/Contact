//
//  ContactUITests.swift
//  ContactUITests
//
//  Created by Stefan Stevanovic on 3/25/19.
//  Copyright © 2019 Joey Tawadrous. All rights reserved.
//

import XCTest

class ContactUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()
        app.navigationBars["People"].buttons[""].tap()
        snapshot("ArchivedPeople")
        app.navigationBars["Archived People"].buttons["People"].tap()
        app.navigationBars["People"].buttons[""].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Buddhist").element.tap()
        snapshot("Achievements")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".otherElements[\"SCLAlertView\"].buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Achievements"].buttons[""].tap()
        let tablesQuery = app.tables
        snapshot("People")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Travel Agent"]/*[[".cells.staticTexts[\"Travel Agent\"]",".staticTexts[\"Travel Agent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("CatchUps")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Agree on destination & price"]/*[[".cells.staticTexts[\"Agree on destination & price\"]",".staticTexts[\"Agree on destination & price\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("CatchUp")
        
        
        
        
    }

}
