//
//  WeatherDetailLayout.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 12/03/2026.
//

import Foundation
import UIKit

//    UICollectionViewCompositionalLayout
//    cards
//    horizontal scrolling
//    grids
//    complex sections
//    nested layouts

enum WeatherDetailLayout {

    static func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            guard let section = Section(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .heroWeather:
                return heroLayout()
            case .hourlyForecast:
                return hourlyLayout()
            case .dailyForecast:
                return heroLayout()
            }
        }
    }
    
    
    
//    ┌──────────────────────────────────┐
//    │                                  │
//    │             London               │
//    │               21°                │
//    │            H:25°  L:17°          │
//    │                                  │
//    └──────────────────────────────────┘
    
//    NSCollectionLayoutSection

    private static func heroLayout() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(180)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(180)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 16,
            bottom: 8,
            trailing: 16
        )

        return section
    }

}
