//
//  ForecastCell.swift
//  Homework_4
//
//  Created by Aliona Starunska on 25.01.2021.
//

import UIKit

class ForecastCell: UITableViewCell, ReusableCell, ConfigurableCell {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configure(with item: WeatherDetails) {
        if let date = item.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = "..."
        }
        temperatureLabel.text = (item.main.temperature > .zero ? "+" : "") + String(format: "%.1f", item.main.temperature)
    }
}
