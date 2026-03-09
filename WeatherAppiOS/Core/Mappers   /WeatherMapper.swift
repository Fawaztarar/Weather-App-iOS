//
//  WeatherMapper.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 25/02/2026.
//

import Foundation
import Foundation

//struct WeatherMapper {
//    
//    static func map(_ dto: WeatherAPIResponse) -> Weather {
//        
//        let date = Date(timeIntervalSince1970: TimeInterval(dto.current.last_updated_epoch))
//        
//        return Weather(
//            city: dto.location.name,
//            temperature: dto.current.temp_c,
//            fetchedAt: date
//        )
//    }
//}
//import Foundation
//
//struct WeatherMapper {
//    
//    static func map(_ dto: WeatherAPIResponse) -> ( WeatherDetail) {
//        
//        let date = Date(
//            timeIntervalSince1970: TimeInterval(dto.current.last_updated_epoch)
//        )
//        
//        let high = dto.forecast.forecastday.first?.day.maxtemp_c ?? 0
//        let low  = dto.forecast.forecastday.first?.day.mintemp_c ?? 0
//        
//        let weather = Weather(
//            city: dto.location.name,
//            temperature: dto.current.temp_c,
//            fetchedAt: date,
//            highTemp: high,
//            lowTemp: low
//        )
//        
//        let hours = dto.forecast.forecastday.first?.hour ?? []
//        
//        let hourly = hours.map { hour in
//            HourlyWeather(
//                time: hour.time,
//                temperature: hour.temp_c,
//                icon: hour.condition.icon
//            )
//        }
//        
//        return  WeatherDetail(weather: weather, hourly: hourly)
//        
//        
//    }
//}
//import Foundation
//
//struct WeatherMapper {
//    
//    static func map(_ dto: WeatherAPIResponse) -> WeatherDetail {
//        
//        let date = Date(
//            timeIntervalSince1970: TimeInterval(dto.current.last_updated_epoch)
//        )
//        
//        let high = dto.forecast.forecastday.first?.day.maxtemp_c ?? 0
//        let low  = dto.forecast.forecastday.first?.day.mintemp_c ?? 0
//        
//        let weather = Weather(
//            city: dto.location.name,
//            temperature: dto.current.temp_c,
//            fetchedAt: date,
//            highTemp: high,
//            lowTemp: low
//        )
//        
//        let hours = dto.forecast.forecastday.first?.hour ?? []
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        
//        let currentHour = Calendar.current.component(.hour, from: Date())
//        
//        let hourly = hours
//            .compactMap { hour -> HourlyWeather? in
//                
//                guard let date = formatter.date(from: hour.time) else { return nil }
//                
//                let hourValue = Calendar.current.component(.hour, from: date)
//                
//                guard hourValue >= currentHour else { return nil }
//                
//                let label = hourValue == currentHour ? "Now" : "\(hourValue)"
//                
//                return HourlyWeather(
//                    time: label,
//                    temperature: hour.temp_c,
//                    icon: hour.condition.icon
//                )
//            }
//            .prefix(12)
//        
//        return WeatherDetail(
//            weather: weather,
//            hourly: Array(hourly),
//            
//            
//        )
//    }
//}
import Foundation

struct WeatherMapper {
    
    static func map(_ dto: WeatherAPIResponse) -> WeatherDetail {
        
        let date = Date(
            timeIntervalSince1970: TimeInterval(dto.current.last_updated_epoch)
        )
        
        let high = dto.forecast.forecastday.first?.day.maxtemp_c ?? 0
        let low  = dto.forecast.forecastday.first?.day.mintemp_c ?? 0
        
        let condition = dto.current.condition.icon
        
        let weather = Weather(
            city: dto.location.name,
            temperature: dto.current.temp_c,
            fetchedAt: date,
            highTemp: high,
            lowTemp: low,
            conditionIcon: condition
        )
        
        // MARK: Hourly
        
        
        // 👇 DEBUG HERE
        print("Forecast days returned:", dto.forecast.forecastday.count)
        
        let hours = dto.forecast.forecastday.first?.hour ?? []
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        let hourly = hours
            .compactMap { hour -> HourlyWeather? in
                
                guard let date = formatter.date(from: hour.time) else { return nil }
                
                let hourValue = Calendar.current.component(.hour, from: date)
                
                guard hourValue >= currentHour else { return nil }
                
                let label = hourValue == currentHour ? "Now" : "\(hourValue)"
                
                return HourlyWeather(
                    time: label,
                    temperature: hour.temp_c,
                    icon: hour.condition.icon
                )
            }
            .prefix(12)
        
        // MARK: Daily Forecast
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd"
        
        // MARK: Daily Forecast

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEE"

        let daily = dto.forecast.forecastday.map { day in
            
            let dayDate = Date(
                timeIntervalSince1970: TimeInterval(day.date_epoch)
            )
            
            let label = Calendar.current.isDateInToday(dayDate)
                ? "Today"
                : weekdayFormatter.string(from: dayDate)
            
            return DailyForecast(
                day: label,
                icon: day.day.condition.icon,
                minTemp: day.day.mintemp_c,
                maxTemp: day.day.maxtemp_c
            )
        }
        return WeatherDetail(
            weather: weather,
            hourly: Array(hourly),
            daily: daily
        )
    }
}
