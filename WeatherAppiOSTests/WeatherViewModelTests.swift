//
//  WeatherViewModelTests.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 18/02/2026.
//

import Foundation
import XCTest
@testable import WeatherAppiOS
import Combine

private var mockDetail: WeatherDetail {
    WeatherDetail(
        weather: Weather(
            city: "London",
            temperature: 10,
            fetchedAt: Date(),
            highTemp: 20,
            lowTemp: 5,
            conditionIcon: "//icon.png"
        ),
        hourly: [],
        daily: []
    )
}

@MainActor
final class WeatherViewModelTests: XCTestCase {
    
    func test_fetchWeather_success_setsLoadedState() async {
        
        let service = MockWeatherService()
        
        let viewModel = WeatherViewModel(service: service)
        
        let MockWeather = mockDetail
        
        service.result = .success(MockWeather)
        
        await viewModel.fetchWeather(for: "London")
        
        XCTAssertEqual(viewModel.state, .loaded(MockWeather))
        

    }
    
    func test_fetchWeather_failure_setsFailedState() async {
        let service = MockWeatherService()
        service.result = .failure(WeatherError.noDataAvailable)
        
        let viewModel = WeatherViewModel(service: service)
        
        await viewModel.fetchWeather(for: "London")
        
        XCTAssertEqual(viewModel.state, .failed(WeatherError.noDataAvailable.localizedDescription))
    }
    
    func test_fetchWeather_nonWeatherError_setsGenericFailedMessage() async {
        
        // Arrange
        let service = MockWeatherService()
        service.result = .failure(URLError(.notConnectedToInternet)) // ✅ NOT a WeatherError
        
        let viewModel = WeatherViewModel(service: service)
        
        // Act
        await viewModel.fetchWeather(for: "London")
        
        // Assert
        XCTAssertEqual(
            viewModel.state,
            .failed("Unable to fetch weather. Please check your API key.")
        )
    }
    
    
    func test_fullStateTrasition_success() async {
        
        let mock = MockWeatherService()
        
        let weather = mockDetail
        
        mock.result = .success(weather)
        mock.delay = 200_000_000
        
        let viewModel = WeatherViewModel(service: mock)
        
        var recordedState: [WeatherState] = []
        
        let cancellable = viewModel.$state
            .sink { state in
                recordedState.append(state)
            }
        
        await viewModel.fetchWeather(for: "London")
        
        XCTAssertEqual(recordedState[0], .idle)
        XCTAssertEqual(recordedState[1], .loading)
        XCTAssertEqual(recordedState[2], .loaded(weather))
        
        cancellable.cancel()
        
        
    }
    
    
    func test_state_idle_to_idle_then_fail_invalidAPIKey_state_failed() async {
        
        let mock = MockWeatherService()
        
        mock.delay = 200_000_000
        
        mock.result = .failure(WeatherError.invalidAPIKey)
        
        let viewModel = WeatherViewModel(service: mock)
        
        var recordedState: [WeatherState] = []
        
        let cancellable = viewModel.$state
            .sink { state in
                recordedState.append(state)
                
            }
        
        await viewModel.fetchWeather(for: "london")
        
        XCTAssertEqual(recordedState[0], .idle)
        XCTAssertEqual(recordedState[1], .loading)
        XCTAssertEqual(recordedState[2], .failed(WeatherError.invalidAPIKey.localizedDescription))
        
        cancellable.cancel()
        
    }
    
    
    func test_idle_loading_failed_failed_loading_success() async {
        let mock = MockWeatherService()
        
        mock.result = .failure(WeatherError.noDataAvailable)
        
        let viewModel = WeatherViewModel(service: mock)
        
        var recordedState: [WeatherState] = []
        
        let cancellables = viewModel.$state
            .sink {state in
                recordedState.append(state)
            }
        
        
        await viewModel.fetchWeather(for: "London")
        
        XCTAssertEqual(recordedState[0], .idle)
        XCTAssertEqual(recordedState[1], .loading)
        XCTAssertEqual(recordedState[2], .failed(WeatherError.noDataAvailable.localizedDescription))
        
      

        let weather = mockDetail
        
        mock.result = .success(weather)
        
        await viewModel.fetchWeather(for: "London")
        
        
     
        XCTAssertEqual(recordedState[3], .loading)
        XCTAssertEqual(recordedState[4], .loaded(weather))
        
        cancellables.cancel()
        
    }
}

