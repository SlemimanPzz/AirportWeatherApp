//
//  IsLoadingView.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 06/09/22.
//

import SwiftUI


///  Loading view for when the ``WeatherManager`` is loading or making requests.
struct IsLoadingView: View {
    
    /// Body of the view.
    var body: some View {
    /// Body of the view.
        Text("Im loading")
    }
}


/// Preview of  ``IsLoadingView``.
struct IsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        IsLoadingView()
    }
}
