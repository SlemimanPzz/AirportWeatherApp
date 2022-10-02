//
//  WeatherManagerErrors.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 13/09/22.
//

import Foundation




/// Exceptions that the ``WeatherManager`` can make.
enum WeatherManagerException : Error {
    
    /// No API key in the ``WeatherManager``.
    case NoAPIkey
    
    /// Error Response from the API.
    case ErrorResponse(error : String)
    
    /// `IATA` code is not lenght  3.
    case InvalidIataLenght
    
    /// `ICAO`code is not lenght 4.
    case InvalidIcaoLenght
    
    /// The local database `Data.realm` wasn't now found.
    case DataBaseNotFound
   
    /// The `ICAO` equivalent  of an `IATA` code was not found the the database.
    case ICAO_CodeNotFound
    
    /// The API has return 0 results for the ``WeatherResponse``
    case ZeroResults
    
    
}



extension WeatherManagerException : LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .NoAPIkey:
            return NSLocalizedString("No API key provided", comment: "NO API key")
        case .ErrorResponse(let error):
            return NSLocalizedString("Response with error, the following httpResponse error happen: \(error)", comment: "IDK")
        case .InvalidIataLenght:
            return NSLocalizedString("IATA codes are exactly of lenght 3.", comment: "IATA code is wrong.")
        case .InvalidIcaoLenght:
            return NSLocalizedString("ICAO codes are exactly of lenght 4.", comment: "ICAO code is wrong.")
        case .DataBaseNotFound:
            return NSLocalizedString("The Data Base wasn't found.", comment: "In divide database not found")
        case .ICAO_CodeNotFound:
            return NSLocalizedString("ICAO code not found in the database.", comment: "ICAO not found")
        case .ZeroResults:
            return NSLocalizedString("The API has found no results for you request.", comment: "No results found for the request.")
        }
    }
    
}
