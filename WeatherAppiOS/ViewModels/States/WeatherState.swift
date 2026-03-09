//
//  WeatherState.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//

import Foundation

enum WeatherState: Equatable {
    case idle
    case loading
    case loaded(WeatherDetail)
    case failed(String)
}
