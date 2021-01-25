//
//  Weather.swift
//  Homework_4
//
//  Created by Aliona Starunska on 21.01.2021.
//

import Foundation

class Weather: Codable {
   
    private(set) var id: Int
    private(set) var main: String
    private(set) var description: String
    
    init(id: Int, main: String, description: String) {
        self.id = id
        self.main = main
        self.description = description
    }
}
