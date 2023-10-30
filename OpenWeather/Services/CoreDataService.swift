//
//  CoreDataService.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 29/10/2023.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    func save(context: NSManagedObjectContext)
    func saveWeatherData(id: Int, name: String, country: String, temperature: Int, overView: String, context: NSManagedObjectContext)
    func deleteWeatherData(withId id: Int, context: NSManagedObjectContext)
    func fetchWeatherData(context: NSManagedObjectContext) -> [WeatherOverview]
}

class CoreDataService: CoreDataServiceProtocol {
    var container = NSPersistentContainer(name: "WeatherDataModel")
    
    // Initialization method for DataController that loads persistent stores.
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    // Method to save changes in the provided NSManagedObjectContext.
    // - Parameters:
    //   - context: The NSManagedObjectContext where changes are to be saved.
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully!")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // Method to save or update weather data in the provided NSManagedObjectContext.
    // - Parameters:
    //   - id: The unique ID for the weather data.
    //   - name: The name of the city.
    //   - country: The country of the city.
    //   - temperature: The temperature in the city.
    //   - overView: The weather overview description.
    //   - context: The NSManagedObjectContext in which to save or update the data.
    func saveWeatherData(id: Int, name: String, country: String, temperature: Int, overView: String, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<WeatherOverview> = WeatherOverview.fetchRequest()
        let uniqueId = Int32(id)
        fetchRequest.predicate = NSPredicate(format: "id == %d", uniqueId)

        do {
            let existingRecord = try context.fetch(fetchRequest).first

            if let existingRecord = existingRecord {
                // A record with the same ID already exists, so updating it.
                existingRecord.country = country
                existingRecord.name = name
                existingRecord.temperature = Int32(temperature)
                existingRecord.overView = overView
            } else {
                // No record with the same ID exists, so create and save a new record.
                let weatherEntity = WeatherOverview(context: context)
                weatherEntity.country = country
                weatherEntity.id = Int32(id)
                weatherEntity.name = name
                weatherEntity.temperature = Int32(temperature)
                weatherEntity.overView = overView
            }
            save(context: context)
        } catch {
            print("Error while checking for existing records or saving: \(error)")
        }
    }
    
    // Method to delete weather data with a specific ID from the provided NSManagedObjectContext.
    // - Parameters:
    //   - id: The unique ID of the weather data to be deleted.
    //   - context: The NSManagedObjectContext from which to delete the data.
    func deleteWeatherData(withId id: Int, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<WeatherOverview> = WeatherOverview.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        if let weatherEntity = try? context.fetch(fetchRequest).first {
            context.delete(weatherEntity)
            save(context: context)
        }
    }
    
    // Method to fetch all weather data from the provided NSManagedObjectContext.
    // - Parameters:
    //   - context: The NSManagedObjectContext from which to fetch the data.
    // - Returns: An array of WeatherOverview objects containing the fetched data.
    func fetchWeatherData(context: NSManagedObjectContext) -> [WeatherOverview] {
        let fetchRequest: NSFetchRequest<WeatherOverview> = WeatherOverview.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
}
