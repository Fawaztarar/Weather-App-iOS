//
//  NetworkService.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 17/02/2026.
//
// responsibilities
// make request
// validate repsponse
// decode JSON into model
// throw errors
import Foundation



final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL: String
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(baseURL: String, session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: EndPoint) async throws -> T {
        
        let request = try endpoint.makeRequest(baseURL: baseURL)
        
        let (data, response) = try await session.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse else {
            
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
            
    }
}

