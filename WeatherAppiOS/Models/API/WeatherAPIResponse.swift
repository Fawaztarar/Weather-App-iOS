//
//  WeatherAPIResponse.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 24/02/2026.
//

import Foundation

struct WeatherAPIResponse: Decodable {
    let location: LocationDTO
    let current: CurrentDTO
    let forecast: ForecastDTO
    
    
    struct LocationDTO: Decodable  {
        let name: String
    }
    
    
    struct CurrentDTO: Decodable {
        let temp_c: Double
        let last_updated_epoch: Int
        let condition: ConditionDTO
    }
    
    struct ConditionDTO: Decodable {
        let icon: String
    }
    
    struct ForecastDTO: Decodable {
        let forecastday: [ForecastDayDTO]
        
        struct ForecastDayDTO: Decodable {
            let day: DayDTO
            let hour: [HourDTO]
            let date_epoch: Int
        }
        
        struct DayDTO: Decodable {
            let maxtemp_c : Double
            let mintemp_c : Double
            let condition: ConditionDTO
        }
    }
    
    struct HourDTO: Decodable {
        let time: String
        let temp_c: Double
        let condition: ConditionDTO
    }
    
   
    
    
}
