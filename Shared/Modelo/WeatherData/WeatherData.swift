//
//  WeatherData.swift
//
//  Proyecto01
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import Foundation



/// Donde se guarda la informacion de la API de CheckWX API
struct WeatherResponse : Decodable {
    let data : [WeatherData]
}

struct WeatherData : Decodable {
    let barometer : Barometer?
    let clouds : [Clouds]?
    let humidity : Humidity?
    let icao : String
    let temperature : Temperature?
    let visibility : Visibility?
    let wind : Wind?
    let station : Station
}

struct Station : Decodable {
    let name : String
}

struct Barometer : Decodable {
    let hg : Float
    let hpa : Float
    let kpa : Float
    let mb : Float
}

struct Clouds : Decodable {
    let code : String
    let text : String
}

struct Humidity : Decodable {
    let percent : UInt8
}

struct Temperature : Decodable {
    let celsius : Int16
    let fahrenheit : Int16
}

struct Visibility : Decodable {
    let meters : String
    let miles : String
}

struct Wind : Decodable {
    let degrees : UInt16
    let speed_kph : UInt16
    let speed_mph : UInt16
    let speed_mps : UInt16
}


