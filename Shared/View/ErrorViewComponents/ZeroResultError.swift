//
//  ZeroResultError.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 30/09/22.
//

import SwiftUI

/// Error View for when the API returns no result.
struct ZeroResultError : View {
    var body: some View {
        Text("The API was not able to return a result.")
        Text("Please try other code")
    }
}
