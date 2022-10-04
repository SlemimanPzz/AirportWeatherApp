//
//  ErrorView.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 06/09/22.
//

import SwiftUI


/// Error view for when something went wrong in the  ``WeatherManager``.
struct ErrorView: View {
    /// ``WeatherManager`` from which the error will be extracted and display.
    @ObservedObject var erroObject : WeatherManager
    
    /// Body of the view.
    var body: some View {
        VStack{
            Text("Some Error Happen")
                .font(.title2)
                .padding()
                .multilineTextAlignment(.center)
            if let error = erroObject.lastError as? WeatherManagerException {
                switch error {
                case .ZeroResults:
                    ZeroResultError()
                case .ICAO_CodeNotFound:
                    ICAO_codeNotFound()
                case .DataBaseNotFound:
                    DataBaseNotFoundError()
                case .ErrorResponse(let error):
                    ErrorHTTPResponse(error: error)
                case .InvalidIataLenght:
                    InvalidIataLenght()
                case .InvalidIcaoLenght:
                    InvalidIcaoLenght()
                case .NoAPIkey:
                    ZeroResultError()
                }
            } else {
                Text(erroObject.lastError?.localizedDescription ?? "Unknown error")
            }
        }
    }
}




/// Preview if  ``ErrorView``.
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(erroObject: WeatherManager())
    }
}
