//
//  OpenWeatherApp.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 24/10/2023.
//

import SwiftUI

@main
struct OpenWeatherApp: App {
    let coreDataService = CoreDataService()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext,
                              coreDataService.container.viewContext)
        }
    }
}
