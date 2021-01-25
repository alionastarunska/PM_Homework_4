//
//  CityCell.swift
//  Homework_4
//
//  Created by Aliona Starunska on 25.01.2021.
//

import UIKit

class CityCell: UITableViewCell, ReusableCell, ConfigurableCell {

    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!

    func configure(with city: City) {
        cityNameLabel.text = city.name
        if let temperature = city.todayWeather?.main.temperature {
            temperatureLabel.text = (temperature > .zero ? "+" : "") + String(format: "%.1f", temperature)
        } else {
            temperatureLabel.text = "..."
        }
    }
}
