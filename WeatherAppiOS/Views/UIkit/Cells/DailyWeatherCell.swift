//
//  DailyWeatherCell.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 13/03/2026.
//

import Foundation
import UIKit

final class DailyWeatherCell: UICollectionViewCell {
    
    static let identifier = "DailyWeatherCell"
    
    private let dayLabel = UILabel()
    private let iconWeather = UIImageView()
    private let highLowLabel = UILabel()
    
    private let stackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func setupViews() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
 
        
        
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        
        dayLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dayLabel.textColor = .black
        
        iconWeather.contentMode = .scaleAspectFit
        
        highLowLabel.font = .systemFont(ofSize: 16, weight: .regular)
        highLowLabel.textColor = .black
        highLowLabel.textAlignment = .right
        
        
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(iconWeather)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(highLowLabel)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            
            iconWeather.widthAnchor.constraint(equalToConstant: 28),
            iconWeather.heightAnchor.constraint(equalToConstant: 28)
            
            
            
        ])
        
    }
    
     func configure(with forecast: DailyForecast) {
        
        dayLabel.text = forecast.day
        
        
        highLowLabel.text = "\(Int(forecast.maxTemp))° / \(Int(forecast.minTemp))°"
        
         let iconURL = forecast.icon

         Task { [weak self] in
             if let image = await WeatherIconLoader.load(from: iconURL) {
                 self?.iconWeather.image = image
             }
         }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconWeather.image = nil
    }
    
    
}
