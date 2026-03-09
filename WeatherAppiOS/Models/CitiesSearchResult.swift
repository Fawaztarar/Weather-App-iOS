//
//  CitiesSearchResult.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 28/02/2026.
//

import Foundation

struct CitiesSearchResult: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let country: String
    let region: String 
}
