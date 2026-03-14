//
//  WeatherAPIResponse+Mock.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 06/03/2026.
//

import Foundation

@testable import WeatherAppiOS

extension WeatherAPIResponse {

    static var mock: WeatherAPIResponse {
        WeatherAPIResponse(
            location: .init(
                name: "London",
                lat: 51.5074,
                lon: -0.1278,
                tz_id: "Europe/London",
                localtime_epoch: nil
            ),
            current: .init(
                temp_c: 15,
                last_updated_epoch: 0,
                condition: .init(icon: "//icon.png")
            ),
            forecast: .init(
                forecastday: [
                    .init(
                        day: .init(
                            maxtemp_c: 20,
                            mintemp_c: 10,
                            condition: .init(icon: "//icon.png")
                        ),
                        hour: [],
                        date_epoch: 0
                    )
                ]
            )
        )
    }
}
