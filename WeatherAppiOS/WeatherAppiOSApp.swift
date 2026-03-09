//
//  WeatherAppiOSApp.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppiOSApp: App {
    private let container = AppContainer()
    
    var body: some Scene {
        WindowGroup {

            CitiesListView(
                vm: container.makeCitiesListVM()
            )
            .modelContainer(for: SavedCity.self)
        }
    }
}
