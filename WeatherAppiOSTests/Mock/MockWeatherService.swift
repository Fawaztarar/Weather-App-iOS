//
//  MockWeatherService.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 18/02/2026.
//

import Foundation
@testable import WeatherAppiOS

final class MockWeatherService: WeatherServiceProtocol {
    
    var result: Result<WeatherDetail, Error>?
    var searchResult: Result<[CitiesSearchResult], Error>?
    
    var delay: UInt64?
    
    func fetch(for city: String) async throws -> WeatherDetail {
        
        if let delay {
            try await Task.sleep(nanoseconds: delay)
        }
        
        guard let result else {
            throw WeatherError.noDataAvailable
        }
        
        return try result.get()
    }
    
    
    func searchCities(for query: String) async throws -> [CitiesSearchResult] {
        guard let searchResult else {
            return []
        }
        return try searchResult.get()
    }
}
