//
//  RealmManager.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 14/03/2026.
//
//
//  RealmManager.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 14/03/2026.
//

import Foundation
import RealmSwift

final class RealmManager {

    static let shared = RealmManager()

    private init() {}

    private lazy var realm: Realm = {

        do {

            let config = Realm.Configuration(
                deleteRealmIfMigrationNeeded: true
            )

            return try Realm(configuration: config)

        } catch {

            fatalError("Realm initialization failed: \(error)")
        }

    }()
    // MARK: - Save Weather

    func saveWeather(_ weather: Weather) {

        let object = WeatherCacheObject()

        object.cityKey = "\(weather.lat),\(weather.lon)"
        object.city = weather.city
        object.lat = weather.lat
        object.lon = weather.lon
        object.temperature = weather.temperature
        object.highTemp = weather.highTemp
        object.lowTemp = weather.lowTemp
        object.conditionIcon = weather.conditionIcon
        object.updatedAt = Date()

        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("❌ Realm write error:", error)
        }
    }

    // MARK: - Load Weather For City

    func loadWeather(lat: Double, lon: Double) -> Weather? {

        let key = "\(lat),\(lon)"

        guard let cached = realm.object(
            ofType: WeatherCacheObject.self,
            forPrimaryKey: key
        ) else {
            return nil
        }

        return mapToWeather(cached)
    }

    // MARK: - Load All Cached Weather

    func loadAllWeather() -> [Weather] {

        let objects = realm.objects(WeatherCacheObject.self)

        return objects.map { mapToWeather($0) }
    }

    // MARK: - Mapper

    private func mapToWeather(_ cached: WeatherCacheObject) -> Weather {

        return Weather(
            city: cached.city,
            lat: cached.lat,
            lon: cached.lon,
            temperature: cached.temperature,
            timezone: cached.timezone,
      
            fetchedAt: cached.updatedAt,
            highTemp: cached.highTemp,
            lowTemp: cached.lowTemp,
            conditionIcon: cached.conditionIcon
        )
    }
}
