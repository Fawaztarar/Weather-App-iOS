//
//  WeatherIconLoader.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 13/03/2026.
//

import Foundation
import UIKit

final class WeatherIconLoader {

    static func load(from iconURL: String) async -> UIImage? {
        let fixedURL = "https:\(iconURL)"

        guard let url = URL(string: fixedURL) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
