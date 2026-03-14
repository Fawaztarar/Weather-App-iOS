//
//   DailyForecast.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
struct DailyForecast: Hashable, Identifiable, Equatable, Sendable {
    let id = UUID()
    let day: String
    let icon: String
    let minTemp: Double
    let maxTemp: Double
}
