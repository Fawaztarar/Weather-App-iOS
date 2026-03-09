//
//  SearchState.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 28/02/2026.
//

import Foundation

enum Loadable<Value> {
    case idle
    case loading
    case loaded(Value)
    case empty
    case failed(String)
}

extension Loadable: Equatable where Value: Equatable {}
