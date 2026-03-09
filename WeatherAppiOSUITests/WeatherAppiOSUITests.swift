//
//  WeatherAppiOSUITests.swift
//  WeatherAppiOSUITests
//
//  Created by Fawaz Tarar on 17/02/2026.
//

//import XCTest
//
//final class WeatherAppiOSUITests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    @MainActor
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    @MainActor
//    func testLaunchPerformance() throws {
//        // This measures how long it takes to launch your application.
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
//}
import XCTest

final class WeatherAppiOSUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    //    @MainActor
    //    func testSearchFieldExists() {
    //
    //        let searchField = app.searchFields.firstMatch
    //
    //        XCTAssertTrue(searchField.waitForExistence(timeout: 2))
    //    }
    //
    //    @MainActor
    //    func testSearchShowsResults() {
    //
    //        let searchField = app.searchFields.firstMatch
    //        searchField.tap()
    //        searchField.typeText("Lon")
    //
    //        let result = app.staticTexts["London"]
    //
    //        XCTAssertTrue(result.waitForExistence(timeout: 3))
    //    }
    //
    //    @MainActor
    //    func testSearchShowsEmptyState() {
    //
    //        let searchField = app.searchFields.firstMatch
    //        searchField.tap()
    //        searchField.typeText("zzzzzz")
    //
    //        let emptyText = app.staticTexts["no search result found"]
    //
    //        XCTAssertTrue(emptyText.waitForExistence(timeout: 3))
    //    }
    //
    //    @MainActor
    //    func testTapSearchResultNavigatesToDetail() {
    //
    //        let searchField = app.searchFields.firstMatch
    //        searchField.tap()
    //        searchField.typeText("Lon")
    //
    //        let result = app.staticTexts["London"]
    //        result.tap()
    //
    //        let detailTitle = app.staticTexts["London"]
    //
    //        XCTAssertTrue(detailTitle.waitForExistence(timeout: 3))
    //    }
    
  
    //    @MainActor
    //    func testSaveCityAndVerifyInList() {
    //
    //        let searchField = app.searchFields.firstMatch
    //        searchField.tap()
    //        searchField.typeText("Lon")
    //
    //        let result = app.staticTexts["London"]
    //        XCTAssertTrue(result.waitForExistence(timeout: 5))
    //        result.tap()
    //
    //        let saveButton = app.buttons["saveCityButton"]
    //        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
    //        saveButton.tap()
    //
    //        app.navigationBars.buttons.element(boundBy: 0).tap()
    //
    //        let savedCity = app.staticTexts["London"]
    //        XCTAssertTrue(savedCity.waitForExistence(timeout: 5))
    //    }
    //}
    //
    //
}
