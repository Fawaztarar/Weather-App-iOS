//
//  FloatingActionButton.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 13/03/2026.
//

import Foundation
import UIKit

final class FloatingActionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        setImage(UIImage(systemName: "plus"), for: .normal)

        tintColor = .white
        backgroundColor = .systemBlue

        layer.cornerRadius = 28

        translatesAutoresizingMaskIntoConstraints = false

        widthAnchor.constraint(equalToConstant: 56).isActive = true
        heightAnchor.constraint(equalToConstant: 56).isActive = true

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 3)
        
        
        // Accessibility
        isAccessibilityElement = true
        accessibilityIdentifier = "saveCityButton"
        accessibilityLabel = "Save city"
        accessibilityHint = "Adds this city to your saved cities"
        accessibilityTraits = .button
    }
}
