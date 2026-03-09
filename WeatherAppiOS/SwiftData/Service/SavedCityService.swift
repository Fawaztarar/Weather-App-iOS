//
//  SavedCityService.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
import SwiftData

final class SavedCityService {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveCity(name: String) {
        
        let city = SavedCity(name: name, createdAt: Date())
        context.insert(city)
        print("city saved")
        
    }
    
    func deleteCity(_ city: SavedCity) {
        context.delete(city)
    }
    
    
}
