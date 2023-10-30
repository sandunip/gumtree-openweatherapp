//
//  Extensions+TimeInterval.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 29/10/2023.
//

import Foundation

extension Int {
    func convertUnixTimestampToTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h.mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        return dateFormatter.string(from: date)
    }
}
