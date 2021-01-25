//
//  WeatherService.swift
//  Homework_4
//
//  Created by Aliona Starunska on 21.01.2021.
//

import Foundation

protocol WeatherService {
    
    func getWeather(for city: City, completion: @escaping (City, Error?) -> ())
    func getForecastWeather(for city: City, completion: @escaping (City, Error?) -> ())
}

class DefaultWeatherService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - WeatherService

extension DefaultWeatherService: WeatherService {
    
    func getWeather(for city: City, completion: @escaping (City, Error?) -> ()) {
        networkService.execute(request: WeatherRequest(city: city.name)) { (response: WeatherDetails?, error) in
            if let weather = response {
                city.todayWeather = weather
            }
            DispatchQueue.main.async {
                completion(city, error)
            }
        }
    }
    func getForecastWeather(for city: City, completion: @escaping (City, Error?) -> ()) {
        networkService.execute(request: ForecastRequest(city: city.name)) { (response: ForecastResponse?, error) in
            if let forecast = response?.list {
                city.forecastWeather = forecast
            }
            DispatchQueue.main.async {
                completion(city, error)
            }
        }
    }
}
