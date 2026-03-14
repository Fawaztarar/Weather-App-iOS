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
    
    
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        bindSearch()
        
    }
    
    
    func loadWeather(for cities: [SavedCity]) async {

        print("🟡 Starting weather load")

        // 1️⃣ Load cache
        let cachedWeather = RealmManager.shared.loadAllWeather()
        print("📦 Cached weather count:", cachedWeather.count)

        for cached in cachedWeather {

            print("📦 Loaded from Realm cache:", cached.city)

            weatherByCity[cached.city] = WeatherDetail(
                weather: cached,
                hourly: [],
                daily: []
            )
        }

        // 2️⃣ Fetch fresh weather
        await withTaskGroup(of: (String, WeatherDetail?).self) { group in

            for city in cities {

                group.addTask {

                    do {

                        print("🌍 Fetching API:", city.name)

                        let detail = try await self.service.fetch(for: city.name)

                        print("💾 Saving to Realm:", city.name)

                        RealmManager.shared.saveWeather(detail.weather)

                        return (city.name, detail)

                    } catch {

                        print("❌ API fetch failed:", city.name)

                        return (city.name, nil)
                    }
                }
            }

            // 3️⃣ Update UI dictionary
            for await result in group {

                if let detail = result.1 {

                    print("🔄 Updating UI with fresh data:", result.0)

                    weatherByCity[result.0] = detail
                }
            }
        }

        print("✅ Weather loading completed")
    }
    
    
//    func loadWeather(for cities: [SavedCity]) async {
//        
//        await withTaskGroup(of: (String, WeatherDetail?).self) { group in
//            
//            for city in cities where weatherByCity[city.name] == nil {
//                
//                group.addTask {
//                    do {
//                        let weather = try await self.service.fetch(for: city.name)
//                        return (city.name, weather)
//                    } catch {
//                        print("failed to fetch weather for \(city.name)")
//                        return (city.name, nil)
//                    }
//                }
//            }
//            
//            for await result in group {
//                if let weather = result.1 {
//                    weatherByCity[result.0] = weather
//                }
//            }
//        }
//    }
    
    private func handleSearch(_ query: String) {
        
        guard !query.isEmpty else {
            searchState = .idle
            return
        }

        searchState = .loading

        Task {
            do {
                let results = try await service.searchCities(for: query)
                
                searchState = results.isEmpty
                    ? .empty
                    : .loaded(results)

            } catch {
                searchState = .failed(error.localizedDescription)
            }
        }
    }

    
    
    private func bindSearch() {
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .sink { [weak self] query in
                self?.handleSearch(query)
            }
            .store(in: &cancellables)
    }
}
