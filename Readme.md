# OpenWeather App
OpenWeather is a simple iOS app that allows users to access weather information by searching for a city name or postal code. It utilizes the OpenWeatherMap API for data retrieval. Users can view current weather conditions for searched locations, access recent searches, and remove them. This project adheres to the MVVM (Model-View-ViewModel) architectural pattern and incorporates unit testing for code reliability.

## Table of Contents
- [Requirements](#requirements)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [How to Use](#how-to-use)
    - [Search by City Name or Postal Code](#search-by-city-name-or-postal-code)
    - [Recent Searches](#recent-searches)
    - [Delete Recent Searches](#delete-recent-searches)
- [Architecture](#architecture)
- [Unit Testing](#unit-testing)
- [Additional Information](#additional-information)


## Requirements
**Search by City Name or Postal Code:**
 Users can input a city name or postal code to retrieve current weather information for the searched location.

**Recent Searches:**
 The app displays a list of recently searched locations, and users can tap on a recent search to view the current weather details for that location.

**Delete Recent Searches:**
 Users can delete one or more of the recently searched locations.

## Getting Started
**Prerequisites**

1.Xcode (v13.0 or higher)
2.Swift (v5.5 or higher)
3. An internet connection to access the OpenWeatherMap API.

## Installation
1. Clone or download this repository.
2. Open the project in Xcode.
3. Build and run the project on a simulator or physical device.

## Project Structure
The project is structured as follows:

1. CoreDataService.swift: 
    Manages the Core Data stack for storing weather data.
2. CityDataManager.swift: 
    Loads city data from a JSON file for use in the app.
3.Data Models: 
    Contains the data models used in the app.
4.Views: 
    Contains the user interface components, including ContentView.
5.WeatherViewModel: 
    Implements the ViewModel for the app.
6.Utilities: 
    Contains utility classes such as APIClient, AppConstants, and URLConstants.
7. Tests: 
    Includes unit tests for the project.
8.Mockdata:
    Includes mockdata for tests.

## How to Use
**Search by City Name or Postal Code**
Open the app.
Select the City or Postcode option and Tap the search bar at the top of the screen.
Enter a city name from the drop down list or postal code and press "Search."
View the current weather information for the searched location.

**Recent Searches**
Scroll down on the main screen to access the list of recent searches.
Tap on a recent search to view the current weather details for that location.

**Delete Recent Searches**
On the Recent Searches screen, swipe left on a search item to reveal a "Delete" button or Click on the Edit button.
Tap "Delete" to remove the search item from the list.

## Architecture
The app follows the MVVM (Model-View-ViewModel) architectural pattern. It separates the application into three core components:

**Model:**
Represents the data and business logic.

**View:**
 Represents the user interface components and their layout.
 
**ViewModel:** 
Acts as an intermediary between the Model and the View, handling data transformation and presentation.

## Unit Testing
Unit tests have been included in the project to ensure the reliability and correctness of the code. Test classes and mock data for testing can be located in the "Tests" directory.

## Additional Information
In terms of additional information, the OpenWeather App makes use of the OpenWeatherMap API to retrieve weather data. To utilize the API, an API key from OpenWeatherMap must be obtained and configured within the project. This can be accomplished by adding the API key to the appropriate location in the APIClient class.
