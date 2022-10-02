//
//  File.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error view for when the http response of the API was not corrrect.
struct ErrorHTTPResponse: View {
    /// Error code of the HTTP response.
    let error : String
    var body: some View {
            Text(WeatherManagerException.ErrorResponse(error: error).localizedDescription)
        if error == "401"{
                Text("Most probably the API key is not valid.")
        }
    }
}
