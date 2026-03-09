//
//  NetworkServiceProtocol.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 19/02/2026.
//

import Foundation


protocol NetworkServiceProtocol {
    
    func request<T: Decodable> (_ endpoint: EndPoint) async throws -> T
}
