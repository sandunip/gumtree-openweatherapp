//
//  WeatherDetailView.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 27/10/2023.
//

import SwiftUI

struct DetailView: View {
    @Binding var weatherData: WeatherData?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text(weatherData?.name ?? "")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.darkBlue)
                    .padding(.top, 10)
                
                let weatherType = weatherData?.weather.first?.main ?? ""
                
                Text(weatherType)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Image(getWeatherType(for: weatherType) ?? .clearSky)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                
                TemperatureView(weatherData: $weatherData)
                    .padding(.top, 20)
                
                
                WeatherGridView(weatherData: $weatherData)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .shadow(color: .gray, radius: 5)
                    .frame(maxHeight: .infinity)
            }
        }
    }
    
    // Method for mapping a weather type string to an ImageResource.
    // - Parameters:
    //   - weatherType: The weather type as a string to be mapped to an ImageResource.
    // - Returns: An ImageResource corresponding to the provided weather type.
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

struct WeatherGridView: View {
    @Binding var weatherData: WeatherData?
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                let feelsLike = ((weatherData?.main.feels_like ?? 0)-AppConstants.kelvinValue).roundedNumber()
                WeatherDetailCell(iconName: "thermometer", label: DetailViewStrings.feelsLike, value: String(feelsLike))
                WeatherDetailCell(iconName: "drop", label: DetailViewStrings.humidity, value: String(weatherData?.main.humidity ?? 0))
                WeatherDetailCell(iconName: "wind", label: DetailViewStrings.windSpeed, value: String(weatherData?.wind.speed ?? 0.0))
            }
            .frame(maxWidth: .infinity)
            
            let sunrise = weatherData?.sys.sunrise.convertUnixTimestampToTime()
            let sunset = weatherData?.sys.sunset.convertUnixTimestampToTime()
            
            HStack {
                WeatherDetailCell(iconName: "sunrise", label: DetailViewStrings.sunrise, value: sunrise ?? "")
                WeatherDetailCell(iconName: "sunset", label: DetailViewStrings.sunset, value: sunset ?? "")
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .background(Color.darkBlue)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct TemperatureView: View {
    @Binding var weatherData: WeatherData?
    
    var body: some View {
        HStack {
            let temperature = ((weatherData?.main.temp ?? 0)-AppConstants.kelvinValue).roundedNumber()
            let temperatureMin = ((weatherData?.main.temp_min ?? 0)-AppConstants.kelvinValue).roundedNumber()
            let temperatureMax = ((weatherData?.main.temp_max ?? 0)-AppConstants.kelvinValue).roundedNumber()
            
            HStack {
                Text(String(temperature))
                    .font(.system(size: 60, weight: .semibold))
                    .foregroundColor(.darkBlue)
                +
                Text(DetailViewStrings.zero)
                    .font(.system(size: 20, weight: .bold))
                    .baselineOffset(40)
                    .foregroundColor(.darkBlue)
            }
            .padding(.leading, 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text("\(DetailViewStrings.minTemperature) \(temperatureMin)")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.gray)
                +
                Text(DetailViewStrings.zero)
                    .font(.system(size: 10, weight: .bold))
                    .baselineOffset(-10)
                    .foregroundColor(.gray)
                
                Text("\(DetailViewStrings.highTemperature) \(temperatureMax)")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.gray)
                +
                Text(DetailViewStrings.zero)
                    .font(.system(size: 10, weight: .bold))
                    .baselineOffset(-10)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 30)
            .baselineOffset(-20)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
