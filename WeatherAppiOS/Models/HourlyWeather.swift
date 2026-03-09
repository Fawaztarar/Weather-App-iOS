//
//  HourlyWeather.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
struct HourlyWeather: Equatable, Identifiable {
    let id = UUID()
    let time: String
    let temperature: Double
    let icon: String 
}
