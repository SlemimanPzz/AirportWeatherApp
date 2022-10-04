//
//  InvalidIcaoLenght.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error view for when the  `ICAO` code lenght is incorrect.
struct InvalidIcaoLenght: View {
    var body: some View {
        Text(WeatherManagerException.InvalidIcaoLenght.localizedDescription)
    }
}
