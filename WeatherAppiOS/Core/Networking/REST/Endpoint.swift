//
//  Endpoint.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 20/02/2026.
//

import Foundation

protocol EndPoint {
 
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    
}

extension EndPoint {
    
    var headers: [String: String]? { nil }
    var body: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
    
}



extension EndPoint {
    func makeRequest(baseURL: String) throws -> URLRequest {
        
        guard var components = URLComponents(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        components.path += path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers?.forEach{ key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
}
