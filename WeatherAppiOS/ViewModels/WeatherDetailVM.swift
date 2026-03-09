//
//  WeatherDetailVM.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 03/03/2026.
//

import Foundation
import Combine

@MainActor
final class WeatherDetailVM: ObservableObject {
  
    
    private let service: WeatherServiceProtocol
    private let city: String
    
   

    var cityName: String {
        city
    }
    
//    private let saveService: SavedCityService
    
    @Published private(set) var state: WeatherState = .idle
    
    
    init(service: WeatherServiceProtocol, city: String, ) {
        self.service = service
        self.city = city
//        self.saveService = saveService
    }
    
    
    func fetch() async {
        
        state = .loading
        
        print("WeatherDetailVM fetch started for city:", city)
        
        do {
            let weather = try await service.fetch(for: city)
            state = .loaded(weather)
            
        } catch let error as WeatherError {
            state = .failed(error.localizedDescription)
        } catch {
            state = .failed("unable to fetch weather")
        }
        
    }
    
//    func save() {
//        saveService.saveCity(name: city)
//    }
}
