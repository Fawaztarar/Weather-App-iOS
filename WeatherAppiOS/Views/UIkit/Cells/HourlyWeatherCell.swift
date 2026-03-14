//
//  HourlyWeatherCell.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 13/03/2026.
//

import Foundation
import UIKit
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

final class HourlyWeatherCell: UICollectionViewCell {
    
    static let identifier = "hourlyWeatherCell"
    
    private let timeLabel = UILabel()
    private let iconWeather = UIImageView()
    private let temperatureLabel = UILabel()
    
    private let cardView = UIView()
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        constraintsView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        contentView.backgroundColor = .clear
        
        //        CardView
        
        cardView.clipsToBounds = true
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        
        contentView.addSubview(cardView)
        // TimeLabel
        
        timeLabel.font = .systemFont(ofSize: 14, weight: .medium)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .center
        
        
        //        iconWeather
        iconWeather.contentMode = .scaleAspectFit
        
        
        //        temperatureLabel
        
        temperatureLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        
        temperatureLabel.textColor = .black
        
        
        //        stackView
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubview(stackView)
        
        
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(iconWeather)
        stackView.addArrangedSubview(temperatureLabel)
        
        
        
    }
    
    
    //    ┌───────────────────────┐
    //    │       16pt            │
    //    │    ┌─────────────┐    │
    //    │    │  stackView  │    │
    //    │    │             │    │
    //    │    │  1 PM       │    │
    //    │    │   ☀️        │    │
    //    │    │  21°        │    │
    //    │    └─────────────┘    │
    //    │       16pt            │
    //    └───────────────────────┘
    private func constraintsView() {
        
        NSLayoutConstraint.activate([
            
            //            cardView fill contentView
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //            StackView
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16)
            
            
        ])
        
    }
    
    func configure(with hourly: HourlyWeather) {
        
        timeLabel.text = hourly.time
        temperatureLabel.text = "\(Int(hourly.temperature))°"
        
        loadWeatherIcon(from: hourly.icon)
    }
    
    private func loadWeatherIcon(from iconURL: String) {
        
        let fixedURL = "https:\(iconURL)"
        
        guard let url = URL(string: fixedURL) else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                guard let image = UIImage(data: data) else { return }

                await MainActor.run {
                    iconWeather.image = image
                }

            } catch {
                print("Failed to load weather icon:", error)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconWeather.image = nil
    }
    
}
