//
//  Weather.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//

import Foundation

struct Weather: Equatable, Decodable, Identifiable {
    
    let id = UUID()
    
    let city: String
    let temperature: Double
    let fetchedAt: Date
    let highTemp: Double
    let lowTemp: Double
    let conditionIcon: String
    
    
    enum CodingKeys: String, CodingKey {
        case city
        case temperature
        case fetchedAt
        case highTemp
        case lowTemp
        case conditionIcon
    }
    
}
