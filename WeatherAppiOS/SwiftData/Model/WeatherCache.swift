//
//  WeatherCache.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 03/03/2026.
//

import Foundation
import SwiftData

@Model
final class WeatherCache {
    var cityName: String
    var temperature: Double
    var updatedAt: Date
    
    init(cityName: String, temperature: Double, updatedAt: Date) {
        self.cityName = cityName
        self.temperature = temperature
        self.updatedAt = updatedAt
    }
}
