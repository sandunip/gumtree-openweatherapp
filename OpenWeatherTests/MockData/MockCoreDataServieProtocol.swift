//
//  MockCoreDataServieProtocol.swift
//  OpenWeatherTests
//
//  Created by Sanduni Perera on 30/10/2023.
//

import CoreData
@testable import OpenWeather
import XCTest

class MockCoreDataServiceProtocol: CoreDataServiceProtocol {
    var saveCalled = false
    var saveWeatherDataCalled = false
    var deleteWeatherDataCalled = false
    var fetchWeatherDataCalled = false
    
    var savedContext: NSManagedObjectContext?
    var savedWeatherData: (id: Int, name: String, country: String, temperature: Int, overView: String, context: NSManagedObjectContext)?
    var deletedWeatherDataId: Int?
    
    var weatherDataToReturn: [WeatherOverview] = []

    func save(context: NSManagedObjectContext) {
        saveCalled = true
        savedContext = context
    }
    
    func saveWeatherData(id: Int, name: String, country: String, temperature: Int, overView: String, context: NSManagedObjectContext) {
        saveWeatherDataCalled = true
        savedWeatherData = (id, name, country, temperature, overView, context)
    }
    
    func deleteWeatherData(withId id: Int, context: NSManagedObjectContext) {
        deleteWeatherDataCalled = true
        deletedWeatherDataId = id
    }
    
    func fetchWeatherData(context: NSManagedObjectContext) -> [WeatherOverview] {
        fetchWeatherDataCalled = true
        return weatherDataToReturn
    }
}

