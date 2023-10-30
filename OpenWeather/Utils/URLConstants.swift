//
//  EndpointUtil.swift
//  OpenWeather
//
//  Created by Sanduni Perera on 25/10/2023.
//

import Foundation

enum URLConstants {
    struct Api {
        static let HOST = "https://api.openweathermap.org"
        
        struct Path {
            static var singleCity:String{
                return HOST + "/data/2.5/weather?q=%@&appid=%@"
            }
        }
        
        struct APIKEY {
            static let APIKEY = "9594a57b59eed0b08afe9d84030e00b1"
        }
    }
}
