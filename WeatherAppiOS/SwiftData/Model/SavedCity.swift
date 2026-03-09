//
//  SavedCity.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 03/03/2026.
//

import Foundation
import SwiftData

@Model
final class SavedCity {
    
    @Attribute(.unique)
    var name: String
    
    var createdAt: Date
    
    init(name: String, createdAt: Date) {
        self.name = name
        self.createdAt = createdAt
    }
}
