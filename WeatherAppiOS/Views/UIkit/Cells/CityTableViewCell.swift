////
////  CityTableViewCell.swift
////  WeatherAppiOS
////
////  Created by Fawaz Tarar on 09/03/2026.
////
//


import UIKit
import Kingfisher

final class CityTableViewCell: UITableViewCell {

    static let identifier = "CityCell"

    private let cardView = UIView()

    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let highLowLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let timeLabel = UILabel()

    private let leftStack = UIStackView()
    private let rightStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupViews() {

        selectionStyle = .none
        backgroundColor = .clear

        // Card container
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        // Typography
//        cityLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        cityLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cityLabel.adjustsFontForContentSizeCategory = true
        cityLabel.textColor = .black
        
        timeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        timeLabel.textColor = .darkGray
        timeLabel.adjustsFontForContentSizeCategory = true

// temperatureLabel.font = .systemFont(ofSize: 46, weight: .thin)
        temperatureLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        temperatureLabel.adjustsFontForContentSizeCategory = true
        temperatureLabel.textColor = .black

//        highLowLabel.font = .systemFont(ofSize: 15, weight: .medium)
        highLowLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        highLowLabel.adjustsFontForContentSizeCategory = true
        highLowLabel.textColor = .gray

        // Icon
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
//        weatherIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        weatherIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let iconBaseSize: CGFloat = 40
        let scaledIconSize = UIFontMetrics(forTextStyle: .body).scaledValue(for: iconBaseSize)
        weatherIcon.widthAnchor.constraint(equalToConstant: scaledIconSize).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: scaledIconSize).isActive = true

        // Left stack
        leftStack.axis = .vertical
        leftStack.spacing = 6
        leftStack.alignment = .leading
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.addArrangedSubview(cityLabel)
        leftStack.addArrangedSubview(timeLabel)
        leftStack.addArrangedSubview(weatherIcon)

        // Right stack
        rightStack.axis = .vertical
        rightStack.spacing = 2
        rightStack.alignment = .trailing
        rightStack.translatesAutoresizingMaskIntoConstraints = false
        rightStack.addArrangedSubview(temperatureLabel)
        rightStack.addArrangedSubview(highLowLabel)

        cardView.addSubview(leftStack)
        cardView.addSubview(rightStack)

        setupConstraints()
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([

            // Card padding inside cell
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            // Left stack
            leftStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            leftStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            leftStack.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12),

            // Right stack
            rightStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            rightStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            rightStack.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -12),

            // Prevent stacks from colliding when fonts grow
            rightStack.leadingAnchor.constraint(greaterThanOrEqualTo: leftStack.trailingAnchor, constant: 12)
            
            
            
        ])
    }

//    private func setupConstraints() {
//
//        NSLayoutConstraint.activate([
//
//            // Card padding inside cell
//            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
//            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
//            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//
//            // Left stack
//            leftStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
//            leftStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
//
//            // Right stack
//            rightStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
//            rightStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
//        ])
//    }

    func configure(city: SavedCity, weather: WeatherDetail?) {

        cityLabel.text = city.name

        guard let weather else {
            temperatureLabel.text = "--"
            highLowLabel.text = ""
            weatherIcon.image = nil
            
            accessibilityLabel = "\(city.name). Weather not available."
            return
        }

        let temp = Int(weather.weather.temperature)
        let high = Int(weather.weather.highTemp)
        let low = Int(weather.weather.lowTemp)

        temperatureLabel.text = "\(temp)°"
        highLowLabel.text = "H:\(high)°  L:\(low)°"

        accessibilityLabel = """
        \(city.name).
        Temperature \(temp) degrees.
        High \(high) degrees.
        Low \(low) degrees.
        """

        if let url = URL(string: "https:\(weather.weather.conditionIcon)") {
            weatherIcon.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "cloud"),
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        }
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short

        if let tz = TimeZone(identifier: weather.weather.timezone) {
            formatter.timeZone = tz
        }

        timeLabel.text = formatter.string(from: weather.weather.fetchedAt)
    }
}
