//
//  CityService.swift
//  Homework_4
//
//  Created by Aliona Starunska on 21.01.2021.
//

import Foundation

protocol CityService {
    func getCities() -> [City]
    func addCity(with name: String) -> City?
    func remove(city: City)
    func save()
}

class DefaultCityService {
    private let defaults: UserDefaults
    private var cities: Set<City>
    
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
        self.cities = Set<City>()
        self.loadFromDefaults()
    }
    
    deinit {
        save()
    }
    
    // MARK: - Private
    
    private func loadFromDefaults() {
        guard let data = defaults.value(forKey: .cities) as? Data,
              let cities = try? PropertyListDecoder().decode(Array<City>.self, from: data) else {
            let _ = addCity(with: .kyiv)
            let _ = addCity(with: .dnipro)
            return
        }
        cities.forEach({
            self.cities.insert($0)
        })
    }
}

// MARK: - CityService

extension DefaultCityService: CityService {
    func getCities() -> [City] {
        return cities.map({ $0 }).sorted(by: { $0.name > $1.name })
    }
    
    func addCity(with name: String) -> City? {
        if let city = cities.first(where: { $0.name == name}) {
            return city
        }
        let city = City(name: name)
        cities.insert(city)
        return city
    }
    
    func remove(city: City) {
        cities.remove(city)
    }
    
    ///https://stackoverflow.com/questions/44876420/save-struct-to-userdefaults
    func save() {
        defaults.set(try? PropertyListEncoder().encode(cities.map({ $0 })), forKey: .cities)
    }
}

// MARK: - Constants

fileprivate extension String {
    static var cities: String { return "cities" }
    
    static var kyiv: String { return "Kyiv" }
    static var dnipro: String { return "Dnipro" }
}
