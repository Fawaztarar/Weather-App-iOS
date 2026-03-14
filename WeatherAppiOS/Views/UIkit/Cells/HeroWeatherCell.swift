//
//  HeroWeatherCell.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 11/03/2026.
//

import UIKit

//HeroWeatherCell
//│
//├ identifier
//│
//├ UI Elements
//│
//├ init()
//│
//├ setupViews()
//│
//├ setupConstraints()
//│
//└ configure()

//UICollectionViewCell
//   │
//   └ contentView
//        │
//        └ cardView
//             │
//             ├ cityLabel
//             ├ temperatureLabel
//             └ highLowLabel


final class HeroWeatherCell: UICollectionViewCell {
    
    static let identifier = "HeroWeatherCell"
    
    
    private let cardView = UIView()
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let highLowLabel = UILabel()
    
    private let stackView = UIStackView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        
        //        • fonts
        //        • colors
        //        • hierarchy
        
        contentView.backgroundColor = .clear
        
        //        Card
        cardView.backgroundColor = .systemBackground
        cardView.layer.cornerRadius = 20
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.clipsToBounds = true
        
        contentView.addSubview(cardView)
        
        //        CityLabel
        cityLabel.font = .systemFont(ofSize: 24, weight: .medium)
        cityLabel.textColor = .label
        
        
        stackView.addSubview(cityLabel)
        
        //        temperatureLabel
        temperatureLabel.font = .systemFont(ofSize: 64, weight: .thin)
        temperatureLabel.textColor = .label
        
        
        //        highLowLabel
        highLowLabel.font = .systemFont(ofSize: 16)
        highLowLabel.textColor = .white
        
        
        
        //        StackView
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(stackView)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(highLowLabel)
        
    }
    
    
    
    
    private func setupConstraints() {
        
        //        UICollectionViewCell
        //        │
        //        └ contentView
        //             │
        //             └ cardView
        //                  │
        //                  ┌───────────────────────────┐
        //                  │                           │
        //                  │        stackView          │
        //                  │      ┌──────────────┐     │
        //                  │      │   city       │     │
        //                  │      │ temperature  │     │
        //                  │      │   high/low   │     │
        //                  │      └──────────────┘     │
        //                  │                           │
        //                  └───────────────────────────┘
        
        NSLayoutConstraint.activate([
            
            //            Card fill cell
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            //            StackView
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
            
        ])
    }
    
    func configure(with weather: Weather) {
        
        cityLabel.text = weather.city
        
        temperatureLabel.text = "\(Int(weather.temperature))°"
        
        isAccessibilityElement = true

        accessibilityLabel = """
        \(weather.city). Temperature \(Int(weather.temperature)) degrees.
        High \(Int(weather.highTemp)) degrees.
        Low \(Int(weather.lowTemp)) degrees.
        """
        
        highLowLabel.text = "H:\(Int(weather.highTemp))°  L:\(Int(weather.lowTemp))°"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        cityLabel.text = nil
        temperatureLabel.text = nil
        highLowLabel.text = nil
    }
}
