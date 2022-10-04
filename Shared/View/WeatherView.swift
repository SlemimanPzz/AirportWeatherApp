//
//  WeatherView.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 06/09/22.
//

import SwiftUI

/// General Weather View that shows the first ``WeatherData`` from ``WeatherResponse``. Uses ``TemperatureComponent``, ``WindComponent``,
/// ``CloudComponent``, and ``HumidityComponent``.
struct WeatherView: View {
    
    /// ``WeatherResponse`` used to construct the view.
    var weather : WeatherResponse
    
    /// Body of the view.
    var body: some View {
        if(weather.data.count != 0){
            VStack {
                
                Text("Weather in  \(weather.data[0].station.name)")
                    .multilineTextAlignment(.center)
                    .padding()
                HStack{
                    Spacer()
                    VStack(alignment: .leading){
                        TemperatureComponent(temperature: weather.data[0].temperature)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        HumidityComponent(humidity: weather.data[0].humidity)
                    }
                    Spacer()
                }
                
                WindComponent(wind: weather.data[0].wind)
                CloudComponent(clouds: weather.data[0].clouds)
                
            }
        } else {
            StartingView()
        }
        
    }
}



/// Preview of ``WeatherView``.
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: WeatherResponse(
            results : 0,
            data: [
                WeatherData(
                    barometer: Barometer(hg: 10.0, hpa: 20.0, kpa: 20.0, mb: 40.0),
                    clouds: [Clouds(code: "-_-", text: "Muy xD")],
                    humidity: Humidity(percent: 50),
                    icao: "MMMX",
                    temperature: Temperature(celsius: 30, fahrenheit: 60),
                    visibility: Visibility(meters: "16,000", miles: "10"),
                    wind: Wind(degrees: 89, speed_kph: 69, speed_mph: 69, speed_mps: 420),
                    station: Station(name: "Prueba")
                )
            ]
        ))
    }
}
