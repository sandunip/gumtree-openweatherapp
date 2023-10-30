//
//  SearchbarView.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 27/10/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search a City", text: $text)
                .padding(.leading, 10)
                .onChange(of: text, perform: { _ in
                    isSearching = true
                })
            
            if isSearching {
                Button(action: {
                    text = ""
                    isSearching = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .border(Color.clear, width: 1)
    }
}
