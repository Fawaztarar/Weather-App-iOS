//
//  WeatherIntegrationTests.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 06/03/2026.
//

import Foundation
import XCTest
@testable import WeatherAppiOS

final class WeatherIntegrationTests: XCTestCase {

    func test_weather_json_decoding_and_mapping() throws {

        // Load JSON from test bundle
        let bundle = Bundle(for: Self.self)

        let url = bundle.url(forResource: "weather", withExtension: "json")!
        let data = try Data(contentsOf: url)

        // Decode DTO
        let dto = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)

        // Map to domain model
        let detail = WeatherMapper.map(dto)

        // Verify mapping
        XCTAssertEqual(detail.weather.city, "Berlin")
        XCTAssertEqual(detail.weather.temperature, 20)
        XCTAssertEqual(detail.weather.highTemp, 25)
        XCTAssertEqual(detail.weather.lowTemp, 15)

        let expectedDate = Date(timeIntervalSince1970: 1)
        XCTAssertEqual(detail.weather.fetchedAt, expectedDate)

        XCTAssertEqual(detail.daily.count, 1)
        XCTAssertTrue(detail.hourly.isEmpty)
    }
}
