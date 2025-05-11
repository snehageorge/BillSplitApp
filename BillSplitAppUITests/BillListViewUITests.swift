//
//  BillListViewUITests.swift
//  BillSplitApp
//
//  Created by Sneha on 09/05/25.
//

import XCTest
@testable import BillSplitApp

class BillListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
    }
    
    func testMainBackgroundAppears() {
        XCTAssertTrue(app.otherElements["main_background"].exists)
    }
    
    func testTopBarAppears() {
        let topBar = app.descendants(matching: .any)["bills_top_bar"]
        XCTAssertTrue(topBar.waitForExistence(timeout: 2), "Top bar did not appear")
    }
    
    func testCarouselViewExistsInPortrait() {
        let carousel = app.otherElements["carousel_view"]
        XCTAssertTrue(carousel.waitForExistence(timeout: 2), "Carousel view did not appear")
    }
    
    func testRecentBillsListAppears() {
        let recentList = app.descendants(matching: .any)["recent_bills_list_view"]
        XCTAssertTrue(recentList.waitForExistence(timeout: 2), "Recent bills list did not appear")
    }
    
    func testNavigationBarTitle() {
        let navigationBarTitle = app.navigationBars.staticTexts["Your Bills"]
        XCTAssertTrue(navigationBarTitle.waitForExistence(timeout: 2),
            "Navigation bar title is not correct"
        )
    }
    
    func testNotificationButtonAppears() {
        let button = app.navigationBars.buttons["notification_button"]
        XCTAssertTrue(button.waitForExistence(timeout: 2), "notification_button did not appear")
    }
}
