//
//  WeatherConditions.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 28/10/2023.
//

import Foundation

enum SearchOption: Int {
    case city
    case postcode
}

enum WeatherTypes:String{
  case CLEAR_SKY = "Clear"
  case CLOUDS = "Clouds"
  case THUDERSTORM = "Thunderstorm"
  case RAIN = "Rain"
  case SNOW = "Snow"
  case MIST = "Mist"
}
