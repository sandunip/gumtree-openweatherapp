//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 25/10/2023.
//

import SwiftUI
import Combine
import CoreData

class WeatherViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    
    func fetchWeatherData(city: String, completion: @escaping (WeatherData?) -> Void) {
        APIClient.shared.fetchWeatherData(city: city) { data in
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

