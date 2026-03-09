//
//  MockNetworkService.swift
//  WeatherAppiOSTests
//
//  Created by Fawaz Tarar on 19/02/2026.
//

import Foundation
@testable import WeatherAppiOS

final class MockNetworkService: NetworkServiceProtocol {

    var result: Result<Any, Error>?
    var lastRequestedRequest: URLRequest?
    var baseURL: String = "https://api.weatherapi.com"

    func request<T: Decodable>(_ endpoint: EndPoint) async throws -> T {

        lastRequestedRequest = try endpoint.makeRequest(baseURL: baseURL)

        guard let result else {
            fatalError("Mock Result not set")
        }

        switch result {
        case .success(let value):
            guard let typed = value as? T else {
                fatalError("Type mismatch. Expected \(T.self), got \(type(of: value))")
            }
            return typed

        case .failure(let error):
            throw error
        }
    }
}
