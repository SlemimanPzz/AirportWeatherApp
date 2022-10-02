//
//  NoAPIkey.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error view for when the API key is missing.
struct NoAPIkey: View {
    var body: some View {
        Text(WeatherManagerException.NoAPIkey.localizedDescription)
    }
}

