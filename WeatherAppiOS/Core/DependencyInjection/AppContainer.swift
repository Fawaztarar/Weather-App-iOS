//
//  AppContainer.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 24/02/2026.
//

import Foundation

final class AppContainer {
    
    lazy var networkService: NetworkServiceProtocol = {
        NetworkService(baseURL: APIConfig.BaseURL)
        
    }()
    
    lazy var weatherService : WeatherServiceProtocol = {
        WeatherService(networkService: networkService)
    }()
    
    
    func makeWeatherViewModel() -> WeatherViewModel {
        WeatherViewModel(service: weatherService)
    }
    
    func makeCitiesListVM() -> CitiesListVM {
        CitiesListVM(service: weatherService)
    }
    
    func makeWeatherDetailVM(city: String) -> WeatherDetailVM {
        WeatherDetailVM(service: weatherService, city: city)
    }
    
}
