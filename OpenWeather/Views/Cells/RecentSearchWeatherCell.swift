//
//  RecentSearchWeatherCell.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 27/10/2023.
//

import SwiftUI

struct WeatherCell: View {
    var cityData: WeatherOverview
    var body: some View {
        
        HStack {
            let city = "\(cityData.name ?? ""), \(cityData.country ?? "")"
            Text(city)
                .font(.headline)
            
            Spacer()
            
            let celciusValue = Double(cityData.temperature) - AppConstants.kelvinValue
            let temperature = celciusValue.roundedNumber()
            
            Text(String(temperature))
                .font(.title)
                .foregroundColor(.darkBlue)
            +
            Text("0")
                .font(.system(size: 15))
                .baselineOffset(20)
                .foregroundColor(.darkBlue)
            
            Image(getWeatherType(for: cityData.overView ?? "") ?? .clearSky)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        }
    }
    
    private func getWeatherType(for weatherType: String) -> ImageResource? {
        switch weatherType {
        case WeatherTypes.CLEAR_SKY.rawValue:
            return .clearSky
        case WeatherTypes.CLOUDS.rawValue:
            return .fewClouds
        case WeatherTypes.THUDERSTORM.rawValue:
            return .thunderstorm
        case WeatherTypes.RAIN.rawValue:
            return .rain
        case WeatherTypes.SNOW.rawValue:
            return .snow
        case WeatherTypes.MIST.rawValue:
            return .mist
        default:
            return .scatteredClouds
        }
    }
}
