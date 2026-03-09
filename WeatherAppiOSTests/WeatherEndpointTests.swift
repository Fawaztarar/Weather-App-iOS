//
//  WeatherEndpointTests.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 24/02/2026.
//

import XCTest
@testable import WeatherAppiOS

@MainActor

final class WeatherEndpointTests: XCTestCase {
    
    func test_makeRequest_current_buildsCorrectRequest() throws {
        
        // Arrange
        let endpoint = WeatherEndpoint.current(city: "London", apiKey: "TEST_KEY")
        let baseURL = "https://api.weatherapi.com/v1"
        
        // Act
        let request = try endpoint.makeRequest(baseURL: baseURL)
        
        // Assert
        XCTAssertEqual(request.httpMethod, "GET")
        
        let urlString = request.url?.absoluteString ?? ""
        
        XCTAssertTrue(urlString.contains("https://api.weatherapi.com/v1/current.json"))
        XCTAssertTrue(urlString.contains("q=London"))
        XCTAssertTrue(urlString.contains("key=TEST_KEY"))
    }
}
