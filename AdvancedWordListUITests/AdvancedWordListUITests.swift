//
//  AdvancedWordListUITests.swift
//  AdvancedWordListUITests
//
//  Created by Anzhellika Sokolova on 22.03.2022.
//

import XCTest

class AdvancedWordListUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    func testAppHas4Tabs() throws {
        XCTAssertEqual(app.tabBars.buttons.count, 4, "There should be 4 tabs in the app.")
    }
    
   
}

