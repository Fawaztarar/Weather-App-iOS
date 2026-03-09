//
//  NetworkError.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 20/02/2026.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidNetwork
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed
    case invalidAPIKey
}

