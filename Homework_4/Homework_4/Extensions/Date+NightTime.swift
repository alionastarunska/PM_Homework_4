//
//  Date+NightTime.swift
//  Homework_4
//
//  Created by Aliona Starunska on 25.01.2021.
//

import Foundation

extension Date {
    var isDarkTime: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour < 7 || hour >= 18
    }
}
