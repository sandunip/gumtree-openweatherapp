//
//  WeatherOverview.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 30/10/2023.
//

import Foundation
import CoreData

extension WeatherOverview {
    // Private static property for the core data fetch request to retrieve WeatherOverview entities.
    private static var weatherFetchRequest: NSFetchRequest<WeatherOverview> {
        NSFetchRequest(entityName: "WeatherOverview")
    }
    
    // Static method to retrieve all WeatherOverview entities.
    // - Returns: An NSFetchRequest<WeatherOverview> for fetching all WeatherOverview entities.
    static func all() -> NSFetchRequest<WeatherOverview> {
        let request: NSFetchRequest<WeatherOverview> = weatherFetchRequest
        request.sortDescriptors = []
        return request
    }
}

