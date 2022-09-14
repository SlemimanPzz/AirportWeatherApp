//
//  HumidityComponet.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI

struct HumidityComponet: View {
    let humidity : Humidity?
    
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

struct HumidityComponet_Previews: PreviewProvider {
    static var previews: some View {
        HumidityComponet(humidity: Humidity(percent: 80))
    }
}
