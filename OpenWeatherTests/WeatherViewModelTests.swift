//
//  WeatherViewModelTests.swift
//  OpenWeatherTests
//
//  Created by Sanduni Perera on 30/10/2023.
//

import Combine
@testable import OpenWeather
import XCTest

class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var coreDataService: MockCoreDataServiceProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        coreDataService = MockCoreDataServiceProtocol()
        viewModel = WeatherViewModel(coreDataService: coreDataService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        coreDataService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchWeatherData() {
        let expectation = XCTestExpectation(description: "Weather data fetched")
        viewModel.fetchWeatherData(city: "New York") { weatherData in
            XCTAssertNotNil(weatherData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}

