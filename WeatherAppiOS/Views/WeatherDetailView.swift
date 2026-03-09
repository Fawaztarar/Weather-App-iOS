//
//  WeatherDetailView.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 28/02/2026.
//

import Foundation
import SwiftUI

struct WeatherDetailView: View {
    
    @StateObject private var vm: WeatherDetailVM
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss


    
    init(vm: WeatherDetailVM) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    private var saveService: SavedCityService {
        SavedCityService(context: context)
    }
    
    var body: some View {
            
            content
            .task {
              
                await vm.fetch()
                
        }
            
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                      
                        Button {
                            saveService.saveCity(name: vm.cityName)
                            dismiss()
                        } label: {
                            Label("Save", systemImage: "plus")
                        }
                        .accessibilityIdentifier("saveCityButton")
                        
                    }
                }
        
            
            
            
        }
    
        
        
        @ViewBuilder
        var content: some View {
            
            switch vm.state {
    
              
            case .idle, .loading:
                ProgressView()
                
            case .loaded(let detail):

            ScrollView {
                VStack(spacing: 20) {

                    heroSection(detail)

                    HourlyForecastCard(hourly: detail.hourly)
                    
                    ForecastCardView(forecast: detail.daily)

                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 10)
                .padding(.horizontal)
            }
                
            case .failed(let message):
                Text(message)
                
                
            }
            
        }
        
        
    }
    

@ViewBuilder
func heroSection(_ detail: WeatherDetail) -> some View {

    VStack(spacing: 8) {

        Text(detail.weather.city)
            .font(.largeTitle)

        Text("\(detail.weather.temperature, specifier: "%.0f")°")
            .font(.system(size: 70, weight: .thin))

//        Text(detail.weather.condition)
//            .font(.title3)

        HStack {
            Text("H:\(detail.weather.highTemp, specifier: "%.0f")°")
            Text("L:\(detail.weather.lowTemp, specifier: "%.0f")°")
        }
        .font(.caption)

    }
}
