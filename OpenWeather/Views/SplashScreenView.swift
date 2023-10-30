//
//  SplashScreenView.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 29/10/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    let coreDataService = CoreDataService()
    var body: some View {
        ZStack{
            Color.darkBlue.ignoresSafeArea()
            
            if isActive {
                ContentView(coreDataService: coreDataService)
            }
            else {
                VStack {
                    Spacer()
                        
                    Image(.weatherIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("OpenWeather")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isActive = true
                    }
                }
            }
        }
    }
}
