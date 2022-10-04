//
//  StartingView.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 07/09/22.
//

import SwiftUI

/// Starting view, from where the app is open. Makes an introduction.
struct StartingView: View {

    /// Body of the view.
    var body: some View {
        VStack{
            Text("Welcome")
                .padding()
            Text("Select the type of code you are going to do your request, first you need to proporcionate a API key of CheckWX")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Text("Down here insert your API key, then click Save API key of CheckWX, then you can get the Weather. If you already save a key before, there is no need insert a new one.")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

/// Preview of the ``StartingView``.
struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
