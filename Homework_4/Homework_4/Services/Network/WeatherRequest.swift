//
//  WeatherRequest.swift
//  Homework_4
//
//  Created by Aliona Starunska on 23.01.2021.
//

import Foundation

///https://openweathermap.org/current#name
struct WeatherRequest {
    
    private let city: String
    
    init(city: String) {
        self.city = city
    }
}

// MARK: - APIRequest

extension WeatherRequest: APIRequest {
    var url: String { return API.weatherByCity }
    var parameters: [String : String] {
        return [.appId: API.appId,
                .city: city,
                .units: .metric]
    }
}

// MARK: - Constants

fileprivate extension String {
    static var appId: String { return "appid" }
    static var city: String { return "q" }
    static var units: String { return "units" }
    static var metric: String { return "metric" }
}
