//
//  API.swift
//  Homework_4
//
//  Created by Aliona Starunska on 23.01.2021.
//

import Foundation

enum API {
    
    // MARK: - Constants
    
    static var appId: String { return "ebba45147d1101ec806ffad0601fdcae" }
    
    // MARK: - Requests
    
    static var weatherByCity: String { return host + "/data/2.5/weather" }
    static var forecastByCity: String { return host + "/data/2.5/forecast" }
    
    // MARK: - Private
    /// https://openweathermap.org/current#name
    private static var host: String { return "https://api.openweathermap.org" }
}
