//
//  WeatherCacheObject.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 14/03/2026.
//

import Foundation
import RealmSwift

class WeatherCacheObject: Object {

    @Persisted(primaryKey: true) var cityKey: String

    @Persisted var city: String
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var timezone: String

    @Persisted var temperature: Double
    @Persisted var highTemp: Double
    @Persisted var lowTemp: Double
    @Persisted var conditionIcon: String

    @Persisted var updatedAt: Date
}
