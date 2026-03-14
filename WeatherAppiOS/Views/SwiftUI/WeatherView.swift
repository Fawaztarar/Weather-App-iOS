//
//  WeatherView.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 24/02/2026.
//

import SwiftUI


struct WeatherView: View {
    
    @StateObject private var vm: WeatherViewModel
    
    init(vm: WeatherViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        
        VStack (spacing: 24) {
            
            FetchButton()
            
            content
        }
        .padding()
        
    }
    
    
    
    @ViewBuilder
    private var content: some View {
        
        switch vm.state {
            
        case .idle:
            Text("")
        case .loading:
            ProgressView()
            
        case .loaded(let detail):
            LoadedView(weather: detail.weather)
            
        case .failed(let error):
            FailedView(message: error)
            
        }
        
    }
    
    struct LoadedView: View {
        let weather:  Weather
        
        var body: some View {
            VStack(spacing: 8) {
                Text(weather.city)
                    .font(.title)
                
                Text("\(weather.temperature, specifier: "%.1f") °C " )
                    .font(.largeTitle)
                
                Text(weather.fetchedAt.formatted())
                    .font(.caption)
                
                
            }
            
        }
        
    }
    
    struct FailedView: View {
        
        let message: String
        
        var body: some View {
            Text("Error \(message)")
                .foregroundColor(.red)
        }
    }
    
    
    private func FetchButton() -> some View {
        Button("Fetch Weather") {
            Task {
                await vm.fetchWeather(for: "Montreal")
            }
        }
        
    }
    
}




//#Preview {
//    WeatherView(
//        vm: WeatherViewModel(
//            service: PreviewService()
//        )
//    )
//}
//
//final class PreviewService: WeatherServiceProtocol {
//    func fetch(for city: String) async throws -> Weather {
//        Weather(city: "Preview", temperature: 0, fetchedAt: .now)
//    }
//}




















//import SwiftUI
//
//struct WeatherView: View {
//
//    @StateObject private var viewModel: WeatherViewModel
//
//    init(viewModel: WeatherViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//
//    var body: some View {
//        VStack(spacing: 24) {
//
//            fetchButton
//
//            contentView
//        }
//        .padding()
//    }
//
//    // MARK: - Subviews
//
//    private var fetchButton: some View {
//        Button("Fetch Montreal") {
//            Task {
//                await viewModel.fetchWeather(for: "Montreal")
//            }
//        }
//    }
//
//    @ViewBuilder
//    private var contentView: some View {
//        switch viewModel.state {
//
//        case .idle:
//            EmptyView()
//
//        case .loading:
//            ProgressView()
//
//        case .loaded(let weather):
//            WeatherContentView(weather: weather)
//
//        case .failed(let error):
//            ErrorView(message: error)
//        }
//    }
//}
//
//struct WeatherContentView: View {
//    let weather: Weather
//
//    var body: some View {
//        VStack(spacing: 8) {
//            Text(weather.city)
//                .font(.title)
//
//            Text("\(weather.temperature, specifier: "%.1f")°C")
//                .font(.largeTitle)
//
//            Text(weather.fetchedAt.formatted())
//                .font(.caption)
//                .foregroundColor(.secondary)
//        }
//    }
//}
//
//struct ErrorView: View {
//    let message: String
//
//    var body: some View {
//        Text("Error: \(message)")
//            .foregroundColor(.red)
//            .multilineTextAlignment(.center)
//    }
//}
