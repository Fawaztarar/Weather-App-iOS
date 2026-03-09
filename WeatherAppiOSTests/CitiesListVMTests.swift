//
//  CitiesListVMTests.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 06/03/2026.
//
import XCTest
@testable import WeatherAppiOS
import Combine

@MainActor
final class CitiesListVMTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    func test_searchText_empty_setsIdleState() async {
        
        let mock = MockWeatherService()
        let viewModel = CitiesListVM(service: mock)
        
        viewModel.searchText = ""
        
        XCTAssertEqual(viewModel.searchState, .idle)
    }
    
    
    func testSearchSuccessSetsLoadedState() async {
        
        let service = MockWeatherService()
        
        let cities = [
            CitiesSearchResult(id: 1, name: "London", country: "UK", region: "England")
        ]
        
        service.searchResult = .success(cities)
        
        let vm = CitiesListVM(service: service)
        
        vm.searchText = "Lon"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertEqual(vm.searchState, .loaded(cities))
    }
    
  
}
