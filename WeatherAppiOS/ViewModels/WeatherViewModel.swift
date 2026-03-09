//
//  WeatherViewModel.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//

import Foundation
import Combine



@MainActor
final class WeatherViewModel: ObservableObject {
    
    private let service: WeatherServiceProtocol
    
   
    @Published private(set) var state: WeatherState = .idle {
        didSet {
            print ("\(state)")
        }
    }
    

    
    
    init(service: WeatherServiceProtocol) {
        self.service = service
    }
    
    
    func fetchWeather(for city: String) async {
        
        state = .loading
//        print("State -> loading..")
        
        do {
            let weather = try await service.fetch(for: city)
            state = .loaded(weather)
//                print("State loaded \(weather.city)")
            
        } catch let error as WeatherError {
            state = .failed(error.localizedDescription)
//            print("State failed -> Weather: \(error)")
        } catch {
            state = .failed("Unable to fetch weather. Please check your API key.")
        }
        
    }
    
    
    
  
    
}
