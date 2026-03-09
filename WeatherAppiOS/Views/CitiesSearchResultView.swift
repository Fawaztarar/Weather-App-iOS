//
//  CitiesSearchResultView.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 28/02/2026.
//

import Foundation
import SwiftUI

struct CitiesSearchResultView: View {
    
    let results: [CitiesSearchResult]
    
    let container:AppContainer
    
    var body: some View {
        
        List(results) { result in
            
            NavigationLink {
                WeatherDetailView(vm: container.makeWeatherDetailVM(city: result.name) )
            } label: {
                
                
                VStack(alignment: .leading) {
                    Text(result.name)
                    
                    Text("\(result.region) , \(result.country)")
                        .font(.caption)
                }
            }
        }
        
    }
}
