//
//  CoinRankerUITests.swift
//  CoinRankerUITests
//
//  Created by Felix kariuki on 24/06/2025.
//

import XCTest

final class CoinRankerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    @MainActor
    func test_views_availability_and_interaction() throws {
        let app = XCUIApplication()
        app.launch()
        
        let appnameText = app.staticTexts["appTitle"]
        let favIcon = app.staticTexts["favIcon"]
        
        // validate app title text present
        XCTAssertTrue(appnameText.waitForExistence(timeout: 2))
        
        // validate top icons present
        XCTAssertTrue(favIcon.waitForExistence(timeout: 2))
        
        // assert click fav icon navigate to favorites
        favIcon.tap()
        let favTitleText = app.staticTexts["favorites"]
        XCTAssertTrue(favTitleText.waitForExistence(timeout: 2))
        
    }
}
