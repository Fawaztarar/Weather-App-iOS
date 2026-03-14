//
//  ForecastCardView.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 04/03/2026.
//

import Foundation
import SwiftUI

struct ForecastCardView: View {
    
    let forecast: [DailyForecast]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Image(systemName: "calendar")
                Text("10-DAY FORECAST")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            
            Divider().opacity(0.3)
            
            ForEach(forecast) { day in
                ForecastRow(day: day)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

import SwiftUI

struct ForecastRow: View {
    
    let day: DailyForecast
    
    var body: some View {
        
        HStack {
            
            Text(day.day)
                .frame(width: 60, alignment: .leading)
            
            AsyncImage(url: URL(string: "https:\(day.icon)")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)
            
            Text("\(Int(day.minTemp))°")
                .frame(width: 40)
            
            TemperatureBar(min: day.minTemp, max: day.maxTemp)
            
            Text("\(Int(day.maxTemp))°")
                .frame(width: 40)
        }
        .font(.subheadline)
    }
}

import SwiftUI

struct TemperatureBar: View {

    let min: Double
    let max: Double

    var body: some View {
        Capsule()
            .fill(.linearGradient(
                colors: [.cyan, .yellow],
                startPoint: .leading,
                endPoint: .trailing
            ))
            .frame(height: 4)
    }
}
