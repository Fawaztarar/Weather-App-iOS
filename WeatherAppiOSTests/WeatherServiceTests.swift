//
//  WeatherServiceTests.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 20/02/2026.
//




import XCTest
@testable import WeatherAppiOS

@MainActor
final class WeatherServiceTests: XCTestCase {

    func test_fetch_returnsWeatherOnSuccess() async throws {
        let mock = MockNetworkService()

        mock.result = .success(WeatherAPIResponse.mock)

        let service = WeatherService(networkService: mock)

        let detail = try await service.fetch(for: "Newyork")

        // Verify mapper output from mock DTO
        XCTAssertEqual(detail.weather.city, "London")
        XCTAssertEqual(detail.weather.temperature, 15)
        XCTAssertEqual(detail.weather.highTemp, 20)
        XCTAssertEqual(detail.weather.lowTemp, 10)

        let expectedDate = Date(timeIntervalSince1970: 0)
        XCTAssertEqual(detail.weather.fetchedAt, expectedDate)
    }

    func test_fetch_throwsNoDataAvailableWhenNetworkFails() async {
        let mock = MockNetworkService()
        mock.result = .failure(NetworkError.invalidNetwork)

        let service = WeatherService(networkService: mock)

        do {
            _ = try await service.fetch(for: "Newyork")
            XCTFail("Expected error to be thrown")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .noDataAvailable)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func test_fetch_callsCorrectEndpoint() async throws {
        let mock = MockNetworkService()
        mock.result = .success(WeatherAPIResponse.mock)

        let service = WeatherService(networkService: mock)

        _ = try await service.fetch(for: "London")

        let urlString = mock.lastRequestedRequest?.url?.absoluteString ?? ""

        XCTAssertTrue(urlString.contains("/forecast.json"))
        XCTAssertTrue(urlString.contains("q=London"))
    }

    func test_fetchWeather_failedWith401Error() async {
        let mock = MockNetworkService()
        mock.result = .failure(NetworkError.invalidStatusCode(401))

        let service = WeatherService(networkService: mock)

        do {
            _ = try await service.fetch(for: "London")
            XCTFail("Expected error")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .invalidAPIKey)
        } catch {
            XCTFail("Unexpected \(error)")
        }
    }

    func test_fetchWeather_failedWith500StatusCode() async {
        let mock = MockNetworkService()
        mock.result = .failure(NetworkError.invalidStatusCode(500))

        let service = WeatherService(networkService: mock)

        do {
            _ = try await service.fetch(for: "London")
            XCTFail("Expected error")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_fetch_failedWithInvalidKey() async {
        let mock = MockNetworkService()
        mock.result = .failure(NetworkError.invalidAPIKey)

        let service = WeatherService(networkService: mock)

        do {
            _ = try await service.fetch(for: "London")
            XCTFail("Expected error")
        } catch let error as WeatherError {
            XCTAssertEqual(error, .invalidAPIKey)
        } catch {
            XCTFail("Unknown error: \(error)")
        }
    }
    
    func test_searchCities_returnsResultsOnSuccess() async throws {

        let mock = MockNetworkService()

        let mockResults = [
            CitiesSearchResult(
                id: 1,
                name: "London",
                country: "United Kingdom",
                region: "England"
            ),
            CitiesSearchResult(
                id: 2,
                name: "London",
                country: "Canada",
                region: "Ontario"
            )
        ]

        mock.result = .success(mockResults)

        let service = WeatherService(networkService: mock)

        let results = try await service.searchCities(for: "London")

        XCTAssertEqual(results.count, 2)
        XCTAssertEqual(results.first?.name, "London")
        XCTAssertEqual(results.first?.country, "United Kingdom")
    }
    
    func test_searchCities_callsCorrectEndpoint() async throws {

        let mock = MockNetworkService()

        let mockResults = [
            CitiesSearchResult(
                id: 1,
                name: "London",
                country: "United Kingdom",
                region: "England"
            )
        ]

        mock.result = .success(mockResults)

        let service = WeatherService(networkService: mock)

        _ = try await service.searchCities(for: "London")

        let urlString = mock.lastRequestedRequest?.url?.absoluteString ?? ""

        XCTAssertTrue(urlString.contains("/search.json"))
        XCTAssertTrue(urlString.contains("q=London"))
    }
    
    func test_searchCities_throwsErrorWhenNetworkFails() async {

        let mock = MockNetworkService()
        mock.result = .failure(NetworkError.invalidNetwork)

        let service = WeatherService(networkService: mock)

        do {
            _ = try await service.searchCities(for: "London")
            XCTFail("Expected error")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
