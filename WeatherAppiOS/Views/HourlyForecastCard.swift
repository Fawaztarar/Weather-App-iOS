//
//  HourlyForecastCard.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
import SwiftUI

struct HourlyForecastCard: View {

    let hourly: [HourlyWeather]

    var body: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 20) {

                ForEach(hourly) { hour in
                    HourlyItem(hour: hour)
                }

            }
            .padding(.horizontal)
        }
    }
}

struct HourlyItem: View {

    let hour: HourlyWeather

    var body: some View {

        VStack(spacing: 8) {

            Text(hour.time)
                .font(.caption)

            AsyncImage(url: URL(string: "https:\(hour.icon)")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)

            Text("\(hour.temperature, specifier: "%.0f")°")
                .font(.caption)

        }
        .frame(width: 50)
    }
}
