//
//  File.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error view for when the data base was not found
struct DataBaseNotFoundError: View {
    var body: some View {
        Text(WeatherManagerException.DataBaseNotFound.localizedDescription)
            .font(.title3)
        Text("You can continue isung the app, only without IATA code availible.")
    }
}
