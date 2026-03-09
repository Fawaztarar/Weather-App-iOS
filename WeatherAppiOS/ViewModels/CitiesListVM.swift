//
//  CitiesListVM.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 28/02/2026.
//

import Foundation
import Combine

@MainActor
final class CitiesListVM: ObservableObject {
    
    @Published var cities: [Weather] = []
    
    private let service: WeatherServiceProtocol
    
    @Published var weatherByCity: [String: WeatherDetail] = [:]
 
    
    @Published var searchText: String = "" {
        didSet {
            handleSearch()
        }
    }
//    @Published var searchResults: [CitiesSearchResult] = []
    @Published var searchState: Loadable<[CitiesSearchResult]> = .idle
    
    private var searchTask: Task <Void, Never>?
    
  
    var filteredCities: [Weather] {
        if searchText .isEmpty {
            return cities
        } else {
            return cities.filter {
                $0.city.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(service: WeatherServiceProtocol) {
        self.service = service
 
        
    }
    
   

    func loadWeather(for cities: [SavedCity]) async {
        
        await withTaskGroup(of: (String, WeatherDetail?).self) { group in
            
            for city in cities where weatherByCity[city.name] == nil {
                
                group.addTask {
                    do {
                        let weather = try await self.service.fetch(for: city.name)
                        return (city.name, weather)
                    } catch {
                        print("failed to fetch weather for \(city.name)")
                        return (city.name, nil)
                    }
                }
            }

            for await result in group {
                if let weather = result.1 {
                    weatherByCity[result.0] = weather
                }
            }
        }
    }
    private func handleSearch() {
 
    
        
        searchTask?.cancel()
        
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !query.isEmpty else {
            searchState = .idle
            return
        }
         
        
        searchState = .loading
        
        
        searchTask = Task {
            
            //        sleep
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            //            cancel guard
            if Task.isCancelled {
                return
            }
            
            do {
                let results = try await service.searchCities(for: query)
           
                
                if results.isEmpty {
                    searchState = .empty
                } else {
                    searchState = .loaded(results)
                }
                
            } catch {
                searchState = .failed(error.localizedDescription)
            }
                
            }
        }
    }

