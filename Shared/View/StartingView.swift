//
//  StartingView.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 07/09/22.
//

import SwiftUI

struct StartingView: View {
    var body: some View {
        VStack{
            Text("Welcome")
                .padding()
            Text("Select the type of code you are going to do your request, first you need to proporcionate a API key of CheckWX")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Text("Down here insert your API key, then click Save API key of CheckWX, then you can get the Weather")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}