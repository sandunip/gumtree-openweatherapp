//
//  ContentView.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 24/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(fetchRequest: WeatherOverview.all()) private var selectedCities
   
    @ObservedObject private var viewModel: WeatherViewModel
    
    @State private var weatherData: WeatherData?
    @State private var selectedOption: SearchOption = .city
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var isDataFetchedError = false
    @State private var isDataFetchedforGeneralSearch = false
    @State private var isDataFetchedforRecentSearch = false
    
    var cities: [CityData] = CityDataManager.loadCityDataFromJSON() ?? []
    var filteredCities: [CityData] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.formattedName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private let coreDataService: CoreDataServiceProtocol
    init(coreDataService: CoreDataServiceProtocol) {
        self.viewModel = WeatherViewModel(coreDataService: coreDataService)
        self.coreDataService = coreDataService
    }
    

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(.lightBlue)
                        .frame(height: 200)

                    VStack {
                        Picker(selection: $selectedOption, label: Text("")) {
                            Text(ContentViewStrings.selectSearchOptionCity).tag(SearchOption.city)
                            Text(ContentViewStrings.selectSearchOptionPostcode).tag(SearchOption.postcode)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: .infinity)
                        
                        SearchBar(text: $searchText, isSearching: $isSearching)
                            .padding(.top, 20)
                        
                        if selectedOption == .city && isSearching {
                            List {
                                ForEach(filteredCities) { city in
                                    Button(action: {
                                        searchText = city.name
                                        isSearching = false
                                    }) {
                                        Text(city.formattedName)
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                        else if selectedOption == .postcode {
                            let isValidPostcode = searchText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
                            if !isValidPostcode {
                                Text(ContentViewStrings.errorInvalidPostcode)
                                    .foregroundColor(Color.red)
                            }
                        }
                        
                        Button(action: {
                            if !searchText.isEmpty {
                                fetchWeatherData(for: searchText, isRecentSearch: false)
                            }
                        }) {
                            Text(ContentViewStrings.buttonTextSearch)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 40)
                        .background(Color.darkBlue)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                        .padding(.top, 5)
                        .disabled(searchText.isEmpty)
                        
                        NavigationLink(destination: DetailView(weatherData: $weatherData), isActive: $isDataFetchedforGeneralSearch) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                HStack {
                    Text(ContentViewStrings.subheadingRecentWeatherSearches)
                        .font(.headline)
                        .padding(.top, 15)
                        .padding(.leading, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    EditButton()
                        .background(Color.lightBlue)
                        .foregroundColor(Color.black)
                        .padding(.trailing, 15)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity)
                
                if selectedCities.isEmpty {
                    Text(ContentViewStrings.errorNoRecords)
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                }
                
                List {
                    ForEach(selectedCities) { city in
                        WeatherCell(cityData: city)
                            .onTapGesture {
                                fetchWeatherData(for: city.name ?? "", isRecentSearch: true)
                            }
                    }
                    .onDelete(perform: deleteCity)
                }
                .background(.lightBlue)
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $isDataFetchedforRecentSearch) {
                    DetailView(weatherData: $weatherData)
                }
                
                Spacer()
            }
            .alert(isPresented: $isDataFetchedError) {
                Alert(title: Text(General.error), message: Text(ContentViewStrings.errorIncorrectCity), dismissButton: .default(Text(General.gotIt)))
            }
            .background(Color.lightBlue)
            .navigationBarTitle(ContentViewStrings.headingSearchCity)
        }
    }
    
    // Method for fetching weather data for a given city.
    // - Parameters:
    //   - city: The name of the city for which weather data is to be fetched.
    //   - isRecentSearch: A boolean indicating whether this is a recent search.
    private func fetchWeatherData(for city: String, isRecentSearch: Bool) {
        viewModel.fetchWeatherData(city: city) { weatherData in
            if let weatherData = weatherData {
                self.weatherData = weatherData
                isDataFetchedforGeneralSearch = !isRecentSearch
                isDataFetchedforRecentSearch = isRecentSearch
                isSearching = false
                saveSelectedCity(weatherData: weatherData)
            }
            else {
                isDataFetchedError = true
            }
        }
    }
    
    // Method to save the weather data for a selected city to Core Data.
    // - Parameters:
    //   - weatherData: The weather data to be saved.
    private func saveSelectedCity(weatherData: WeatherData) {
        coreDataService.saveWeatherData(
            id: weatherData.id,
            name: weatherData.name,
            country: weatherData.sys.country,
            temperature: Int(weatherData.main.temp),
            overView: weatherData.weather.first!.main,
            context: managedObjContext
        )
    }
    
    // Method to delete selected cities from the list.
    // - Parameters:
    //   - offsets: The IndexSet containing the indices of cities to be deleted.
    private func deleteCity(offsets: IndexSet) {
        withAnimation {
            offsets.map { selectedCities[$0] }
            .forEach(managedObjContext.delete)
            
            coreDataService.save(context: managedObjContext)
        }
    }
}
