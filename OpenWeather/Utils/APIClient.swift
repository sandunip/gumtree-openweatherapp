//
//  APIClient.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 25/10/2023.
//

import Foundation

enum WeatherInfoRouter{
    case getWeatherInfo(String,String)
    
    var url:URL {
        switch self {
        case .getWeatherInfo(let city,let apiKey):
            return URL(string: String(format: URLConstants.Api.Path.singleCity, city, apiKey))!
        }
    }
}

class APIClient {
    static let shared = APIClient()
    
    func fetchWeatherData(city: String, completion: @escaping (WeatherData?) -> Void) {
        let weatherURL = WeatherInfoRouter.getWeatherInfo(city, URLConstants.Api.APIKEY.APIKEY).url

        URLSession.shared.dataTask(with: weatherURL) { (data, _, error) in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(decodedData)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else if let error = error {
                print("Error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

