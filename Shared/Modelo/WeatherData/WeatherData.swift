//
//  WeatherData.swift
//
//  Proyecto01
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import Foundation



/// Weather response from the API.
struct WeatherResponse : Decodable {
    
    /// Number of result.
    let results : UInt
    
    /// Array of ``WeatherData``. It can be mutiple because it can be more that 1 station.
    let data : [WeatherData]
}


/// Weather data from a station.
struct WeatherData : Decodable {
    
    /// The measure pressure.
    let barometer : Barometer?
    
    /// Array of ``clouds``. Many because it's broken by altitude.
    let clouds : [Clouds]?
    
    /// The measure humidity.
    let humidity : Humidity?
    
    /// The `ICAO` string of the station.
    let icao : String
    
    /// The measure temperature.
    let temperature : Temperature?
    
    /// The current visibility.
    let visibility : Visibility?
    
    /// The measure wind.
    let wind : Wind?
    
    /// The Station the data was taken.
    let station : Station
}


/// Station name.
struct Station : Decodable {
    /// The name of the station.
    let name : String
}


/// The pressure.
struct Barometer : Decodable {
    
    /// Pressure in inHG (Inch of mercury)
    let hg : Float
    
    ///Pressure in Atmospheric pressure
    let hpa : Float
    
    /// Pressure in kPA (kilopascal)
    let kpa : Float
    
    /// Pressure in mb (milibar)
    let mb : Float
}


/// Cloud description.
struct Clouds : Decodable {
    
    /// `METAR` cloud code.
    let code : String
    
    /// Text description of the clouds.
    let text : String
}

/// Air humidity.
struct Humidity : Decodable {
    
    /// Porcent of ambient humidity.
    let percent : UInt8
}


/// Measurre ambient temperature.
struct Temperature : Decodable {
    
    /// Temperature in Celsius.
    let celsius : Int16
    
    /// Temperature in Fahrenheit.
    let fahrenheit : Int16
}


/// Current visibility distance.
struct Visibility : Decodable {
    
    /// Visibility distance in meters.
    let meters : String
    
    /// Visibility distance in miles.
    let miles : String
}


/// Wind conditions
struct Wind : Decodable {
    
    /// Wind dirrection in degrees, north equals to zero.
    let degrees : UInt16
    
    /// Wind speed in km/h.
    let speed_kph : UInt16
    
    /// Wind speed in mi/h.
    let speed_mph : UInt16
    
    /// WInd speed in m/s.
    let speed_mps : UInt16
}


