//
//  WeatherManager.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import Foundation
import RealmSwift


/// Class that manages Weather Requests.
class WeatherManager : ObservableObject {
    
    /// Private dictionary that acts has cache from the Weathes
    private var AirportWeatherCache : [String : (WeatherResponse, Date)] = [:]
     
    /// The API key that will be used to make requests.
    var APIkey : String?
    
    ///  Published variable that informs of the last weather obtain.
    @Published var lastWeather : WeatherResponse = WeatherResponse(data: [])
    
    /// Published variable that informs of the last response made from the API.
    @Published var lastResponse : URLResponse? = nil
    
    /// Published varibale that informs of, if any, last ``WeatherManagerException``  made by the ``WeatherManager``.
    @Published var lastError : String? = nil
    
    /// Published variable that informs if the ``WeatherManager`` is making any oparation.
    @Published var isLoading  = false
    
    /// Published variable that informs if ``lastWeather`` was from ``AirportWeatherCache``.
    @Published var fromCache = false
    
   
    
    /// Transform IATA codes to ICAO codes. Also updates `lastError` if an error had happen.
    /// - Parameter iata: IATA code that will be transform
    /// - Returns: `ERROR` if an error happen, if not found retorn `ICAO not found`, or the equivalent ICAO code.
    func iataToIcao(iata : String) -> String {
        if iata.count != 3 {
            lastError = WeatherManagerException.InvalidIataLenght.localizedDescription
        }
        
        
        let realmURL = Bundle.main.url(forResource: "Data", withExtension: ".realm")
        guard let realmURL = realmURL else {
            lastError = "Data Base not found"
            return "ERROR"
        }
        
        let realm = try! Realm(fileURL: realmURL)
        
        let realmObs = realm.objects(IataIcaoCodes.self)
        
        
        let response = realmObs.first {
            $0.IATA == iata
        }
        
        guard let response = response else {
            lastError = "ICAO not found"
            return "ERROR"
        }
        
        return response.ICAO!
    }
    
    
    /// Get the Weather from IATA codes. Updates ``lastError`` and ``lastWeather``, dependeing of how the API response.
    /// - Parameter iata: The IATA code from the wish Airport.
    func getWeather(iata : String){
        if(iata.count != 3){
            lastError = WeatherManagerException.InvalidIataLenght.localizedDescription
            return
        }
        getWeather(icao: iataToIcao(iata: iata))
    }
    
    
    
    
    
    /// Get the Weather from ICAO codes. Updates ``lastError`` and ``lastWeather``, dependeing of how the API response.
    /// - Parameter icao: The ICAO code from thw wish Airport.
    func getWeather(icao : String){
        if(icao == "ERROR"){
            return
        }
        if(icao.count != 4){
            lastError = WeatherManagerException.InvalidIcaoLenght.localizedDescription
            return
        }
        if let cacheWeather = AirportWeatherCache[icao] {
            
            let minutesOfWeatherAntiquityThreshold = 10
            
            if cacheWeather.1.timeIntervalSinceNow < Double(-60 * minutesOfWeatherAntiquityThreshold) {
                guard APIkey != nil else {
                    lastError = WeatherManagerException.NoAPIkey.localizedDescription
                    return
                }
                fetchWeather(icao: icao)
                return
            }
            
            fromCache = true
            lastWeather = cacheWeather.0
            return
        }
        guard APIkey != nil else {
            lastError = WeatherManagerException.NoAPIkey.localizedDescription
            return
        }
        fetchWeather(icao: icao)
        
    }
    
    
    
    
    /// Fetches the weather from the API. Updates ``lastError`` and ``lastWeather`` depending of how the API responses.
    /// - Parameter icao: The ICAO weather from the wish Airport.
    func fetchWeather(icao : String) {
        isLoading = true
        lastError = nil
        fromCache = false
        
        
        guard let APIkey = APIkey, APIkey != "" else {
            lastError = WeatherManagerException.NoAPIkey.localizedDescription
            isLoading = false
            return
        }
        
        guard let url =  URL(string : "https://api.checkwx.com/metar/\(icao)/decoded/?x-api-key=\(APIkey)") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url){[unowned self] data, response, error in
            
            guard case self.APIkey = APIkey else {
                lastError = WeatherManagerException.NoAPIkey.localizedDescription
                return
            }
            
            
            DispatchQueue.main.async {
                self.isLoading = false
                self.lastWeather = WeatherResponse(data: [])
            }
            
            let decoder = JSONDecoder()
            
            
            
            let httpResponse = response as? HTTPURLResponse
                    
            guard let httpResponse = httpResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    if error == nil{
                        self.lastError = WeatherManagerException.ErrorResponse(error: httpResponse?.statusCode.description ?? "Not found").localizedDescription
                    }
                }
                return
            }
            
            
            
            if let data = data {
                
                do{
                    let result = try decoder.decode(WeatherResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.lastWeather = result
                        self.AirportWeatherCache[icao] = (self.lastWeather, Date())
                    }
                    
                    
                } catch DecodingError.dataCorrupted(_){
                    DispatchQueue.main.async {
                        self.lastError = error?.localizedDescription
                    }
                }
                catch{
                    DispatchQueue.main.async {
                        self.lastError = error.localizedDescription
                    }
                }
            }
        }
        
        if lastError == nil{
            task.resume()
        }
        
    }
}
