//
//  WeatherManager.swift
//  Proyecto01 (iOS)
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import Foundation
import RealmSwift


class WeatherManager : ObservableObject {
    private var AirportWeatherCache : [String : (WeatherResponse, Date)] = [:]
     
    var APIkey : String?
    
    @Published var lastWeather : WeatherResponse = WeatherResponse(data: [])
    @Published var lastResponse : URLResponse? = nil
    @Published var lastError : String? = nil
    @Published var isLoading  = false
    @Published var fromCache = false
    
   
    
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
            print("ICAO no obtenido")
            lastError = "ICAO not found"
            return "ERROR"
        }
        print(response)
        
        return response.ICAO!
    }
    
    
    func getWeather(iata : String){
        if(iata.count != 3){
            lastError = WeatherManagerException.InvalidIataLenght.localizedDescription
            return
        }
        getWeather(icao: iataToIcao(iata: iata))
    }
    
    
    
    
    
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
            
            print("Checking time")
            if cacheWeather.1.timeIntervalSinceNow < Double(-60 * minutesOfWeatherAntiquityThreshold) {
                print("Weather too old")
                guard APIkey != nil else {
                    lastError = WeatherManagerException.NoAPIkey.localizedDescription
                    return
                }
                fetchWeather(icao: icao)
                return
            }
            
            fromCache = true
            print("From  cache")
            lastWeather = cacheWeather.0
            return
        }
        guard APIkey != nil else {
            lastError = WeatherManagerException.NoAPIkey.localizedDescription
            return
        }
        fetchWeather(icao: icao)
        
    }
    
    
    
    
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
                print("Error with the response, unexpected status code: \(String(describing: httpResponse?.statusCode))")
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
                    
                    
                } catch DecodingError.dataCorrupted(let xD){
                    DispatchQueue.main.async {
                        self.lastError = error?.localizedDescription
                        print(error?.localizedDescription ?? "=(")
                        print(xD.debugDescription)
                    }
                }
                catch{
                    DispatchQueue.main.async {
                        self.lastError = error.localizedDescription
                        print(error)
                        print("\n")
                        print(data.description)
                    }
                }
            }
        }
        
        if lastError == nil{
            task.resume()
        }
        
    }
}
