//
//  HourlyWeather.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
struct HourlyWeather: Hashable, Equatable, Identifiable, Sendable {
    let id = UUID()
    let time: String
    let temperature: Double
    let icon: String 
}
