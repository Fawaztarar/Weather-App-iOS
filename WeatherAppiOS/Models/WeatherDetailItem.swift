//
//  WeatherDetailItem.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 12/03/2026.
//

import Foundation


nonisolated enum WeatherDetailItem: Hashable, Sendable {
    case hero(Weather)
    case hourly(HourlyWeather)
    case daily(DailyForecast)
}
