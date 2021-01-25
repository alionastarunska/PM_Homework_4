//
//  WeatherDetails.swift
//  Homework_4
//
//  Created by Aliona Starunska on 23.01.2021.
//

import Foundation

class WeatherDetails: Codable {
    
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // https://nsdateformatter.com
        return formatter.date(from: dateString ?? "")
    }
    private(set) var weather: [Weather]
    private(set) var main: WeatherDetailsMain
    private var dateString: String?
    
    private enum CodingKeys: String, CodingKey {
        case weather, main
        case dateString = "dt_txt"
    }
    
    init(weather: [Weather], main: WeatherDetailsMain) {
        self.weather = weather
        self.main = main
    }
}
