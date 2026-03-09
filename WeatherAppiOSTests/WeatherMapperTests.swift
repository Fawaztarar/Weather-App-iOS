//
//  WeatherMapperTests.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 25/02/2026.
//

import Foundation
import XCTest
@testable import WeatherAppiOS

@MainActor
final class WeatherMapperTests: XCTestCase {
    
    func test_dto_map_to_model() async {
        
        let dto = WeatherAPIResponse.mock
        
        let detail = WeatherMapper.map(dto)
        
        XCTAssertEqual(detail.weather.city, "London")
        XCTAssertEqual(detail.weather.temperature, 15)
        
        let expectedDate = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(detail.weather.fetchedAt, expectedDate)
    }
    
    
    func test_mapper_maps_all_fields_correctly() {
        
        let dto = WeatherAPIResponse.mock
        
        let detail = WeatherMapper.map(dto)
        
        // Weather fields
        XCTAssertEqual(detail.weather.city, "London")
        XCTAssertEqual(detail.weather.temperature, 15)
        XCTAssertEqual(detail.weather.highTemp, 20)
        XCTAssertEqual(detail.weather.lowTemp, 10)
        XCTAssertEqual(detail.weather.conditionIcon, "//icon.png")
        
        let expectedDate = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(detail.weather.fetchedAt, expectedDate)
        
        // Daily forecast
        XCTAssertEqual(detail.daily.count, 1)
        
        let daily = detail.daily.first!
        XCTAssertEqual(daily.maxTemp, 20)
        XCTAssertEqual(daily.minTemp, 10)
        XCTAssertEqual(daily.icon, "//icon.png")
        
        // Hourly forecast (mock contains none)
        XCTAssertTrue(detail.hourly.isEmpty)
    }
}
