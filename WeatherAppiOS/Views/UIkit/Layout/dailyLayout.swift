//
//  dailyLayout.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 13/03/2026.
//

import Foundation
import UIKit

extension WeatherDetailLayout {
    static func dailyLayout() -> NSCollectionLayoutSection {
        
        
        let itemsize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemsize)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 12
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        
        return section
        
    }
}
