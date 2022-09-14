//
//  TemperatureComponent.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI

struct TemperatureComponent: View {
    let temperature : Temperature?
    
    var body: some View{
        
        if let temperature = temperature {
            VStack(alignment: .leading){
                Text("Temperature")
                Text("\(temperature.celsius)°C")
                Text("\(temperature.fahrenheit)°F")
            }
        } else {
            VStack(alignment: .leading){
                Text("I couldn't get the temperature")
            }
        
        }
    }
}

struct TemperatureComponent_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureComponent(temperature: Temperature(celsius: 50, fahrenheit: -50))
    }
}
