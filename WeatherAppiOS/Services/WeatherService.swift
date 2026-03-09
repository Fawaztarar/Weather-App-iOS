//
//  WeatherService.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 19/02/2026.
//

import Foundation


final class WeatherService: WeatherServiceProtocol {
 
    
    private let networkService: NetworkServiceProtocol

    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetch(for city: String) async throws -> ( WeatherDetail){
        
        let endpoint = WeatherEndpoint.forecast(
            city: city,
            days: 10,
            apiKey: APIConfig.apiKey,
         
        )
        
        do {
            let dto: WeatherAPIResponse = try await networkService.request(endpoint)
            return WeatherMapper.map(dto)
            
        } catch let error as NetworkError {
            
            switch error {
                
            case .invalidStatusCode(let code):
                if code == 401 {
                    throw WeatherError.invalidAPIKey
                } else {
                    throw WeatherError.invalidResponse
                }
            case .decodingFailed, .invalidResponse:
                throw WeatherError.invalidResponse
                
            case .invalidAPIKey:
                throw WeatherError.invalidAPIKey
                
            case .invalidNetwork, .invalidURL:
                throw WeatherError.noDataAvailable
                
            }
        } catch {
                throw WeatherError.noDataAvailable
            }
        
    }
    
    
  
 
            
        func searchCities(for query: String) async throws -> [CitiesSearchResult] {
            
            let endpoint = WeatherEndpoint.search(
                query: query,
                apiKey: APIConfig.apiKey
            )
            
            return try await networkService.request(endpoint)
        }

        
    }
    
    
   
    



