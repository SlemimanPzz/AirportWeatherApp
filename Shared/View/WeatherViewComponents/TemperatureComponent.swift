//
//  TemperatureComponent.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI

/// View that shows the temperature. Needs a ``temperature``, else says it couldn't get it.
struct TemperatureComponent: View {
    
    /// Temperature of the view.
    let temperature : Temperature?
    
    /// Body of the view.
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

/// Preview of ``TemperatureComponent``.
struct TemperatureComponent_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
        TemperatureComponent(temperature: Temperature(celsius: 50, fahrenheit: -50))
        }
    }
}
