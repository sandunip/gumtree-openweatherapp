//
//  City.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 27/10/2023.
//

import Foundation

struct CityData: Identifiable, Codable {
    let id: Int
    let name: String
    let country: String
    
    var formattedName: String {
        return "\(name), \(country)"
    }
}
