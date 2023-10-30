//
//  WeatherDetailCell.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 30/10/2023.
//

import SwiftUI

struct WeatherDetailCell: View {
    let iconName: String
    let label: String
    let value: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.title)
                .padding(.bottom, 5)
                .foregroundColor(Color.white)
            
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color.white)
            
            Text(value)
                .font(.headline)
                .foregroundColor(Color.white)
        }
        .padding(20)
    }
}
