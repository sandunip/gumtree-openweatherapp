//
//  Strings.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 30/10/2023.
//

import Foundation

internal enum General {
    internal static let emptyString = ""
    internal static let error = "Error"
    internal static let gotIt = "Got it!"
}

internal enum ContentViewStrings {
    internal static let selectSearchOptionCity = "City"
    internal static let selectSearchOptionPostcode = "Postcode"
    
    internal static let errorInvalidPostcode =  "Invalid Postcode"
    internal static let errorNoRecords = "There are no records at the moment."
    internal static let errorIncorrectCity = "Please make sure the city you entered is correct."
    
    internal static let buttonTextSearch =  "Search"
    
    internal static let headingSearchCity = "Search a City"
    internal static let subheadingRecentWeatherSearches = "Recent Weather Searches"
}

internal enum DetailViewStrings {
    internal static let zero = "0"
    internal static let minTemperature = "L"
    internal static let highTemperature = "H"

    internal static let feelsLike = "Feels Like"
    internal static let humidity = "Humidity"
    internal static let windSpeed = "Wind Speed"
    internal static let sunrise = "Sunrise"
    internal static let sunset = "Sunset"
}

