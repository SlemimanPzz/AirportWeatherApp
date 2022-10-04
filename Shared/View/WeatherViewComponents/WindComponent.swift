//
//  WindComponent.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI

/// View that shows the wind. Needs a ``wind``, else says it couldn't get it.
struct WindComponent: View {
    
    /// Wind of the view.
    let wind  : Wind?
    
    /// Body of the view.
    var body: some View {
        HStack{
            if let wind = wind {
                VStack{
                    Text("N").padding()
                    
                    HStack{
                        Text("W").padding()
                        Label("", systemImage: "location.north.fill").rotationEffect(Angle.degrees(Double(wind.degrees)))
                        Text("E").padding()
                    }
                    Text("S").padding()
                }
                VStack(alignment : .trailing){
                    Text("Winds of speeds of")
                    Text("\(wind.speed_kph) km/h")
                    Text("\(wind.speed_mph) mp/h")
                    Text("\(wind.speed_mps) m/s")
                }
            } else {
                Text("Couldn't get the wind.")
            }
        }
    }
}

/// Preview of ``WindComponent``.
struct WindComponent_Previews: PreviewProvider {
    static var previews: some View {
        WindComponent(wind: Wind(degrees: 69, speed_kph: 69, speed_mph: 69, speed_mps: 69))
    }
}
