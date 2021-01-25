//
//  City.swift
//  Homework_4
//
//  Created by Aliona Starunska on 21.01.2021.
//

import Foundation

class City: Codable, Hashable, Equatable {

    let name: String
    var todayWeather: WeatherDetails?
    var forecastWeather: [WeatherDetails]
    
    init(name: String, todayWeather: WeatherDetails? = nil, forecastWeather: [WeatherDetails] = []) {
        self.name = name
        self.todayWeather = todayWeather
        self.forecastWeather = forecastWeather
    }
    
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(name.lowercased())
    }
    
    // MARK: - Equatable
    static func == (lhs: City, rhs: City) -> Bool { return lhs.name == rhs.name }
}
