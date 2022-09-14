//
//  ErrorView.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 06/09/22.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var erroObject : WeatherManager
    
    var body: some View {
        VStack{
            Text("Some Error Happen")
                .font(.title2)
                .padding()
            Text(erroObject.lastError ?? "I don't know what went wrong")
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(erroObject: WeatherManager())
    }
}
