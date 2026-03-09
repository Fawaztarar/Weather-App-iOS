//
//  WeatherProtocol.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetch(for city: String) async throws -> ( WeatherDetail)
    func searchCities(for query: String) async throws -> [CitiesSearchResult]
}
