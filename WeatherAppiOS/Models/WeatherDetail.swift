//
//  WeatherDetail.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
struct WeatherDetail: Equatable {
    let weather: Weather
    let hourly: [HourlyWeather]
    let daily: [DailyForecast]
}
