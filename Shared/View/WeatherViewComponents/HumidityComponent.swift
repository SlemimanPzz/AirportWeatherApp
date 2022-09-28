//
//  HumidityComponet.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI


/// View that shows the humidity. Needs a ``Humidity``, else says it couldn't get it.
struct HumidityComponent: View {
    
    /// Humidity of the view.
    let humidity : Humidity?
    
    /// Body of the view.
    var body: some View {
        if let humidity = humidity {
                
            VStack(alignment: .trailing){
                Text("Humidity")
                Text("\(humidity.percent)%")
                Text("")
            }
        } else {
            VStack(alignment: .trailing){
                Text("Couldn't get the humidity")
            }
        }
    }
}

/// Preview of ``HumidityComponent``.
struct HumidityComponet_Previews: PreviewProvider {
    static var previews: some View {
        HumidityComponent(humidity: Humidity(percent: 80))
    }
}
