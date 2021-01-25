//
//  DetailsWeather.swift
//  Homework_4
//
//  Created by Aliona Starunska on 21.01.2021.
//

import Foundation

class WeatherDetailsMain: Codable {
    
    private(set) var temperature: Float
    private(set) var feelsLike: Float
    private(set) var tempMin: Float
    private(set) var tempMax: Float
    private(set) var pressure: Int
    private(set) var humidity: Int

    private enum CodingKeys: String, CodingKey {
        case pressure, humidity
        case temperature = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
   
    init(temperature: Float, feelsLike: Float, tempMin: Float, tempMax: Float, pressure: Int, humidity: Int) {
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
    }
    
}
