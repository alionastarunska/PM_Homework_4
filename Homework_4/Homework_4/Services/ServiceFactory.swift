//
//  ServiceFactory.swift
//  Homework_4
//
//  Created by Aliona Starunska on 21.01.2021.
//

import Foundation

class ServiceFactory {
    
    // MARK: - Private
    /// Made as a variable to make sure that SceneDelegate uses same instance as ListViewController does
    private var cityService = DefaultCityService()
    
    // MARK: - Singleton
    static var shared = ServiceFactory()
    private init() {}
    
    // MARK: - Services
    
    func makeCityService() -> CityService {
        return cityService
    }
    
    func makeWeatherService() -> WeatherService {
        return DefaultWeatherService(networkService: makeNetworkService())
    }
    
    // MARK: - Private
    
    private func makeNetworkService() -> NetworkService {
        return DefaultNetworkService()
    }
}
