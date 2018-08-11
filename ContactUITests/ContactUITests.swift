//
//  ContactUITests.swift
//  ContactUITests
//
//  Created by Joey Tawadrous on 31/03/2018.
//  Copyright © 2018 Joey Tawadrous. All rights reserved.
//

import XCTest

class ContactUITests: XCTestCase {
        
	override func setUp() {
		super.setUp()
		
		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
		// UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		XCUIApplication().launch()
		
		// In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
		let app = XCUIApplication()
		setupSnapshot(app)
		app.launch()
	}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
		let app = XCUIApplication()
		
		let tablesQuery = app.tables
		snapshot("People")
		tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Travel Agent"]/*[[".cells.staticTexts[\"Travel Agent\"]",".staticTexts[\"Travel Agent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		snapshot("CatchUps")
		tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Agree on destination & price"]/*[[".cells.staticTexts[\"Agree on destination & price\"]",".staticTexts[\"Agree on destination & price\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		snapshot("CatchUp")
    }
}
