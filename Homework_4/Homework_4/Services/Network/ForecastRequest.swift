//
//  ForecastRequest.swift
//  Homework_4
//
//  Created by Aliona Starunska on 25.01.2021.
//

import Foundation

///https://openweathermap.org/api/hourly-forecast
struct ForecastRequest {
    
    private let city: String
    
    init(city: String) {
        self.city = city
    }
}

// MARK: - APIRequest

extension ForecastRequest: APIRequest {
    var url: String { return API.forecastByCity }
    var parameters: [String : String] {
        return [.appId: API.appId,
                .city: city,
                .units: .metric]
    }
}


// MARK: - Response

struct ForecastResponse: Codable {
    var list: [WeatherDetails]
}

// MARK: - Constants

fileprivate extension String {
    static var appId: String { return "appid" }
    static var city: String { return "q" }
    static var units: String { return "units" }
    static var metric: String { return "metric" }
}
