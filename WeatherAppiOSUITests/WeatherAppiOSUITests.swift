//
//  WeatherAppiOSUITests.swift
//  WeatherAppiOSUITests
//
//  Created by Fawaz Tarar on 17/02/2026.
//


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
    
        @MainActor
        func testSearchFieldExists() {
    
            let searchField = app.searchFields.firstMatch
    
            XCTAssertTrue(searchField.waitForExistence(timeout: 2))
        }
    
        @MainActor
        func testSearchShowsResults() {
    
            let searchField = app.searchFields.firstMatch
            searchField.tap()
            searchField.typeText("Lon")
    
            let result = app.staticTexts["London"]
    
            XCTAssertTrue(result.waitForExistence(timeout: 3))
        }
    
        @MainActor
    func testSearchShowsEmptyState() {

        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("zzzzzz")

        XCTAssertFalse(app.staticTexts["London"].exists)
    }
    
        @MainActor
        func testTapSearchResultNavigatesToDetail() {
    
            let searchField = app.searchFields.firstMatch
            searchField.tap()
            searchField.typeText("Lon")
    
            let result = app.staticTexts["London"]
            result.tap()
    
            let detailTitle = app.staticTexts["London"]
    
            XCTAssertTrue(detailTitle.waitForExistence(timeout: 3))
        }
    
  
        @MainActor
        func testSaveCityAndVerifyInList() {
    
            let searchField = app.searchFields.firstMatch
            searchField.tap()
            searchField.typeText("Lon")
    
            let result = app.staticTexts["London"]
            XCTAssertTrue(result.waitForExistence(timeout: 5))
            result.tap()
    
            let saveButton = app.buttons["saveCityButton"]
            XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
            saveButton.tap()
    
            app.navigationBars.buttons.element(boundBy: 0).tap()
    
            let savedCity = app.staticTexts["London"]
            XCTAssertTrue(savedCity.waitForExistence(timeout: 5))
        }
  
    @MainActor
    func testDeleteSavedCity() {

        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Barcelona")

        let result = app.staticTexts["Barcelona"].firstMatch
        XCTAssertTrue(result.waitForExistence(timeout: 5))
        result.tap()

        let saveButton = app.buttons["saveCityButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()

        app.navigationBars.buttons.element(boundBy: 0).tap()

        let savedCity = app.tables.staticTexts["Barcelona"]
        XCTAssertTrue(savedCity.waitForExistence(timeout: 5))

        savedCity.swipeLeft()

        let deleteButton = app.buttons["Delete"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 2))
        deleteButton.tap()

        XCTAssertFalse(app.tables.staticTexts["Barcelona"].exists)
    }
    }
    
    

