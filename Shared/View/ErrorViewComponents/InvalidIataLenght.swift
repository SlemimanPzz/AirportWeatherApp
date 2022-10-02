//
//  InvalidIataLenght.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error view for when the lenght of the `IATA` code is not correct.
struct InvalidIataLenght: View {
    var body: some View {
        Text(WeatherManagerException.InvalidIataLenght.localizedDescription)
    }
}
