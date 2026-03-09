//
//  CitiesListView.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 27/02/2026.
//

import Foundation
import SwiftUI
import SwiftData

struct CitiesListView: View {
    
    @StateObject var vm: CitiesListVM
    
    let container =  AppContainer()
    
    @Query(sort: \SavedCity.createdAt, order: .reverse)
    private var savedCities: [SavedCity]
    
    @Query
    private var weatherCache: [WeatherCache]
    
    @Environment(\.modelContext) private var modelContext
    
    private var cityService: SavedCityService {
        SavedCityService(context: modelContext)
    }
    
    
    init(vm: CitiesListVM) {
            _vm = StateObject(wrappedValue: vm)
        }
    
  
    
    var body: some View {
        
        NavigationStack {
            
            if vm.searchText .isEmpty {
                
                SavedCitiesView
              
            
            } else {
                searchContent
            }
            
        }
        .task {
            await vm.loadWeather(for: savedCities)
        }
        .onChange(of: savedCities) { oldValue, newValue in
            Task {
                await vm.loadWeather(for: newValue)
            }
        }
        .onAppear {
            vm.searchText = ""
        }
        .searchable(text: $vm.searchText)
    }
    
    
    
    private var SavedCitiesView: some View {

        if savedCities.isEmpty {
            return AnyView(
                EmptyStateView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }

        return AnyView(
            List {
                ForEach(savedCities) { city in
                    
                    NavigationLink {
                        WeatherDetailView(
                            vm: container.makeWeatherDetailVM(city: city.name)
                        )
                    } label: {
                        CardView(
                            weather: vm.weatherByCity[city.name],
                            cityName: city.name
                        )
                    }
                    .buttonStyle(.plain)
                    .swipeActions {
                        Button(role: .destructive) {
                            cityService.deleteCity(city)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .accessibilityIdentifier("deleteCityButton")
                    }
                }
            }
            .listStyle(.plain)
        )
    }
  
    @ViewBuilder
    private var searchContent: some View {
        
        switch vm.searchState {
            
        case .idle:
            SavedCitiesView
        case .empty:
          Text("no cities found")
                .foregroundColor(.gray)
        case .loading:
            ProgressView()
        case .loaded(let result):
            CitiesSearchResultView(results: result, container: container)
            
        case .failed(let message):
            Text(message)
        }
    }
    
}

struct EmptyStateView: View {
    
    var body: some View {
        VStack(spacing: 12) {
            
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundStyle(.gray)
            
            Text("Search for a city")
                .font(.headline)
            
            Text("Use the search bar to find weather.")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        .multilineTextAlignment(.center)
    }
}
struct CardView: View {
    
//    let city: SavedCity
    let weather: WeatherDetail?
    
    let cityName: String
    
    
    var body: some View {
        
        
        HStack(alignment: .top) {
            
            VStack(alignment: .leading) {
                Text(cityName)
                    .font(.title)
                    .lineLimit(2)
                    .accessibilityIdentifier(cityName)
                
                if let weather {
                    AsyncImage(url: URL(string: "https:\(weather.weather.conditionIcon)")) { Image in Image
                        
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                        .frame(width: 30, height: 30)
                }

               
            }
            
            Spacer ()
            
            if let weather {
                
                VStack() {
                    Text("\(weather.weather.temperature, specifier: "%.0f") °")
                        .font(.largeTitle)
                    
                    HStack {
                        Text("H:\(weather.weather.highTemp, specifier: "%.0f")°")
                            .font(.caption)
                        Text("L:\(weather.weather.lowTemp, specifier: "%.0f")°")
                            .font(.caption)
                    }
                }
                
            } else {
                ProgressView()
            }
        }
        .padding()
       
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.gray)
        )
        
        
    }
    
}

//#Preview {
//    CitiesListView()
//}
