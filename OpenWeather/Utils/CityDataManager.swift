//
//  CityDataManager.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 27/10/2023.
//

import Foundation

class CityDataManager {
    
    // Static method to load city data from a JSON file in the main bundle.
    // - Returns: An array of CityData objects if successful, or nil if there was an error.
    static func loadCityDataFromJSON() -> [CityData]? {
        if let path = Bundle.main.path(forResource: "current.city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let cities = try decoder.decode([CityData].self, from: data)
                return cities
            } catch {
                print("Error loading city data from JSON: \(error)")
            }
        }
        return nil
    }
}
