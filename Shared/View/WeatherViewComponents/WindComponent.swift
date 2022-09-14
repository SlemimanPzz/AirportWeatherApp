//
//  WindComponent.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI

struct WindComponent: View {
    let wind  : Wind?
    
    var body: some View {
        HStack{
            if let wind = wind{
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

struct WindComponent_Previews: PreviewProvider {
    static var previews: some View {
        WindComponent(wind: Wind(degrees: 69, speed_kph: 69, speed_mph: 69, speed_mps: 69))
    }
}
