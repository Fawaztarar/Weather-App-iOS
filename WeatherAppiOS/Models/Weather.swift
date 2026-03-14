//
//  Weather.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//

import Foundation

//struct Weather: Hashable, Decodable, Identifiable, Sendable{
//    
//        let id = UUID()
//
//    
//    let city: String
//
//    let temperature: Double
//    let fetchedAt: Date
//    let highTemp: Double
//    let lowTemp: Double
//    let conditionIcon: String
//    
//    
//    enum CodingKeys: String, CodingKey {
//        case city
//        case temperature
//        case fetchedAt
//        case highTemp
//        case lowTemp
//        case conditionIcon
//    }
//}
//
//struct Weather: Hashable, Decodable, Identifiable, Sendable {
//
//    var id: String {
//        "\(lat)-\(lon)"
//    }
//
//    let city: String
//    let lat: Double
//    let lon: Double
//    let temperature: Double
//    let fetchedAt: Date
//    let highTemp: Double
//    let lowTemp: Double
//    let conditionIcon: String
//}
struct Weather: Decodable, Identifiable, Sendable {

    nonisolated var id: String { "\(lat),\(lon)" }

    let city: String
    let lat: Double
    let lon: Double
    let temperature: Double
    let timezone: String
    let fetchedAt: Date
    let highTemp: Double
    let lowTemp: Double
    let conditionIcon: String
}

extension Weather: Hashable {}
