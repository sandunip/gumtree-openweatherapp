//
//  CoreDataServiceTests.swift
//  OpenWeatherTests
//
//  Created by Sanduni Perera on 30/10/2023.
//
@testable import OpenWeather
import XCTest
import CoreData

final class CoreDataServiceTests: XCTestCase {

    var testContainer: NSPersistentContainer!
    var coreDataService: CoreDataService!
    
    override func setUp() {
        super.setUp()

        testContainer = MockCoreDataStack().persistentContainer
        coreDataService = CoreDataService()
        coreDataService.container = testContainer
    }

    override func tearDown() {
        testContainer = nil
        coreDataService = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(coreDataService.container)
        XCTAssertNotNil(coreDataService.container.persistentStoreCoordinator)
    }
    
    func test_SaveWeatherData() {
        let context = coreDataService.container.viewContext
        
        // Create test data
        let id = 1
        let name = "City"
        let country = "Country"
        let temperature = 25
        let overview = "Sunny"
        
        // Save the data
        coreDataService.saveWeatherData(id: id, name: name, country: country, temperature: temperature, overView: overview, context: context)
        
        // Fetch the saved data
        let savedData = coreDataService.fetchWeatherData(context: context)
        
        // Verify the saved data
        XCTAssertEqual(savedData.count, 1)
        let firstRecord = savedData.first!
        XCTAssertEqual(firstRecord.id, Int32(id))
        XCTAssertEqual(firstRecord.name, name)
        XCTAssertEqual(firstRecord.country, country)
        XCTAssertEqual(firstRecord.temperature, Int32(temperature))
        XCTAssertEqual(firstRecord.overView, overview)
    }
    
    func testDeleteWeatherData() {
        let context = coreDataService.container.viewContext
        
        // Create and save a test record
        let id = 1
        let name = "City"
        let country = "Country"
        let temperature = 25
        let overview = "Sunny"
        
        coreDataService.saveWeatherData(id: id, name: name, country: country, temperature: temperature, overView: overview, context: context)
        
        // Delete the test record
        coreDataService.deleteWeatherData(withId: id, context: context)
        
        // Fetch the data and verify it's empty
        let savedData = coreDataService.fetchWeatherData(context: context)
        XCTAssertEqual(savedData.count, 0)
    }
    
    func testFetchWeatherData() {
        let context = coreDataService.container.viewContext
        
        // Create and save test records
        let data1 = WeatherOverview(context: context)
        data1.id = 1
        data1.name = "City1"
        data1.country = "Country1"
        data1.temperature = 20
        data1.overView = "Cloudy"
        
        let data2 = WeatherOverview(context: context)
        data2.id = 2
        data2.name = "City2"
        data2.country = "Country2"
        data2.temperature = 30
        data2.overView = "Rainy"
        
        // Fetch the data
        let fetchedData = coreDataService.fetchWeatherData(context: context)
        
        // Verify the fetched data
        XCTAssertEqual(fetchedData.count, 2)
        
        let firstRecord = fetchedData[0]
        XCTAssertEqual(firstRecord.id, 1)
        XCTAssertEqual(firstRecord.name, "City1")
        XCTAssertEqual(firstRecord.country, "Country1")
        XCTAssertEqual(firstRecord.temperature, 20)
        XCTAssertEqual(firstRecord.overView, "Cloudy")
        
        let secondRecord = fetchedData[1]
        XCTAssertEqual(secondRecord.id, 2)
        XCTAssertEqual(secondRecord.name, "City2")
        XCTAssertEqual(secondRecord.country, "Country2")
        XCTAssertEqual(secondRecord.temperature, 30)
        XCTAssertEqual(secondRecord.overView, "Rainy")
    }
}
