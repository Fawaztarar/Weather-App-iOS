//
//  WeatherEndpoint.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 20/02/2026.
//

import Foundation

enum WeatherEndpoint: EndPoint {
    
    case current(city: String, apiKey: String)
    case search(query: String, apiKey: String)
    case forecast(city: String, days: Int, apiKey: String)
    
    var path: String {
        switch self {
        case .current:
            return "/current.json"
        case .search:
            return "/search.json"
        case .forecast:
            return "/forecast.json"
        }
       
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .current(let city, let apiKey):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: city)
            ]
            
        case .forecast(let city, let days, let apiKey):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "days", value: "\(days)")
            ]
            
        case .search(let query, let apiKey):
            return [
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: "q", value: query)
            ]
        }
    }
}
