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
//        let condition = dto.current.condition.icon
//        
////        let weather = Weather(
////            city: dto.location.name,
////            temperature: dto.current.temp_c,
////            fetchedAt: date,
////            highTemp: high,
////            lowTemp: low,
////            conditionIcon: condition
////        )
////
//        
//        let weather = Weather(
//            city: dto.location.name,
//            lat: dto.location.lat,
//            lon: dto.location.lon,
//            temperature: dto.current.temp_c,
//            fetchedAt: date,
//            highTemp: high,
//            lowTemp: low,
//            conditionIcon: condition
//        )
//
//        // MARK: Hourly
//        
//        
//        // 👇 DEBUG HERE
//        print("Forecast days returned:", dto.forecast.forecastday.count)
//        
//        let hours = dto.forecast.forecastday.first?.hour ?? []
//        
//        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//
//        let displayFormatter = DateFormatter()
//        displayFormatter.dateFormat = "h a"
//
//        let cityNow = Date(
//            timeIntervalSince1970: TimeInterval(
//                dto.location.localtime_epoch ?? dto.current.last_updated_epoch
//            )
//        )
//
//        let currentHour = Calendar.current.component(.hour, from: cityNow)
//
//
//        let hourly = hours
//            .compactMap { hour -> HourlyWeather? in
//                
//                guard let date = inputFormatter.date(from: hour.time) else { return nil }
//                
//                let hourValue = Calendar.current.component(.hour, from: date)
//                
//                guard hourValue >= currentHour else { return nil }
//                
//                let label = hourValue == currentHour
//                    ? "Now"
//                    : displayFormatter.string(from: date)
//                
//                return HourlyWeather(
//                    time: label,
//                    temperature: hour.temp_c,
//                    icon: hour.condition.icon
//                )
//            }
//            .prefix(12)
//        
//        // MARK: Daily Forecast
//        
//        let dayFormatter = DateFormatter()
//        dayFormatter.dateFormat = "yyyy-MM-dd"
//        
//        // MARK: Daily Forecast
//
//        let weekdayFormatter = DateFormatter()
//        weekdayFormatter.dateFormat = "EEE"
//
//        let daily = dto.forecast.forecastday.map { day in
//            
//            let dayDate = Date(
//                timeIntervalSince1970: TimeInterval(day.date_epoch)
//            )
//            
//            let label = Calendar.current.isDateInToday(dayDate)
//                ? "Today"
//                : weekdayFormatter.string(from: dayDate)
//            
//            return DailyForecast(
//                day: label,
//                icon: day.day.condition.icon,
//                minTemp: day.day.mintemp_c,
//                maxTemp: day.day.maxtemp_c
//            )
//        }
//        return WeatherDetail(
//            weather: weather,
//            hourly: Array(hourly),
//            daily: daily
//        )
//    }
//}
import Foundation

struct WeatherMapper {
    
    static func map(_ dto: WeatherAPIResponse) -> WeatherDetail {
        
        // MARK: Base Weather
        
        let fetchedDate = Date(
            timeIntervalSince1970: TimeInterval(dto.current.last_updated_epoch)
        )
        
        let high = dto.forecast.forecastday.first?.day.maxtemp_c ?? 0
        let low  = dto.forecast.forecastday.first?.day.mintemp_c ?? 0
        
        let weather = Weather(
            city: dto.location.name,
            lat: dto.location.lat,
            lon: dto.location.lon,
            temperature: dto.current.temp_c,
            timezone: dto.location.tz_id,
            fetchedAt: fetchedDate,
            highTemp: high,
            lowTemp: low,
            conditionIcon: dto.current.condition.icon
        )
        
        
        // MARK: Timezone
        
        let timezone = TimeZone(identifier: dto.location.tz_id) ?? .current
        
        var calendar = Calendar.current
        calendar.timeZone = timezone
        
        
        // MARK: Formatters
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        inputFormatter.timeZone = timezone
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "h a"
        displayFormatter.timeZone = timezone
        
        
        // MARK: Current City Time
        
        let cityNow = Date(
            timeIntervalSince1970: TimeInterval(
                dto.location.localtime_epoch ?? dto.current.last_updated_epoch
            )
        )
        
        
        // MARK: Hourly Forecast
        
//        let hours = dto.forecast.forecastday.first?.hour ?? []
        let hours = dto.forecast.forecastday
            .flatMap { $0.hour }
        
        let hourly = hours
            .compactMap { hour -> HourlyWeather? in
                
                guard let hourDate = inputFormatter.date(from: hour.time) else {
                    return nil
                }
                
                // Only future hours
                guard hourDate >= cityNow else {
                    return nil
                }
                
                let label = calendar.isDate(hourDate, equalTo: cityNow, toGranularity: .hour)
                    ? "Now"
                    : displayFormatter.string(from: hourDate)
                
                return HourlyWeather(
                    time: label,
                    temperature: hour.temp_c,
                    icon: hour.condition.icon
                )
            }
            .prefix(12)
        
        
        // MARK: Daily Forecast
        
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEE"
        weekdayFormatter.timeZone = timezone
        
        let daily = dto.forecast.forecastday.map { day in
            
            let dayDate = Date(
                timeIntervalSince1970: TimeInterval(day.date_epoch)
            )
            
            let label = calendar.isDateInToday(dayDate)
                ? "Today"
                : weekdayFormatter.string(from: dayDate)
            
            return DailyForecast(
                day: label,
                icon: day.day.condition.icon,
                minTemp: day.day.mintemp_c,
                maxTemp: day.day.maxtemp_c
            )
        }
        
        
        // MARK: Final Model
        
        return WeatherDetail(
            weather: weather,
            hourly: Array(hourly),
            daily: daily
        )
    }
}
