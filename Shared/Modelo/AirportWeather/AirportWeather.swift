//
//  AirportWeather.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import Foundation



/// Estructura para almacenar la informacion de clima del aeropuerto.
struct AirpotWeather : Decodable {
    let data : [WeatherData]
}



