//
//  Extensions+Double.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 29/10/2023.
//

import Foundation

extension Double {
    func roundedNumber() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if let rounded = formatter.string(from: NSNumber(value: self)) {
            return rounded
        } else {
            return "Invalid Number"
        }
    }
}
