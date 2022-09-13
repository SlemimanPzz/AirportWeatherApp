//
//  WeatherManagerErrors.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 13/09/22.
//

import Foundation


enum WeatherManagerException : Error{
    case NoAPIkey
    case ErrorResponse(error : String)
    case InvalidIataLenght
    case InvalidIcaoLenght
}



extension WeatherManagerException : LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .NoAPIkey:
            return NSLocalizedString("No API key provided", comment: "IDK")
        case .ErrorResponse(let error):
            return NSLocalizedString("Response with error, the following httpResponse error happen: \(error)", comment: "IDK")
        case .InvalidIataLenght:
            return NSLocalizedString("Los codigos IATA son de logitud 3 exactamente", comment: "Iata mal")
        case .InvalidIcaoLenght:
            return NSLocalizedString("Los codigos ICAO son de longitud 4 exatamente", comment: "Icao mal")
        }
    }
    
}
