//
//  File.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error view for when the ICAO equivalent code for a IATA code was not found in the database.
struct ICAO_codeNotFound: View {
    var body: some View {
        Text(WeatherManagerException.ICAO_CodeNotFound.localizedDescription)
    }
}
