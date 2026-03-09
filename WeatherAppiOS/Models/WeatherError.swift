//
//  WeatherError.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 18/02/2026.
//

import Foundation

enum WeatherError: LocalizedError {
    case noDataAvailable
    case invalidAPIKey
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .noDataAvailable:
            return "No data available."
        case .invalidAPIKey:
            return "Invalid API key."
        case .invalidResponse:
            return "Invalid server response."
        }
    }
}
