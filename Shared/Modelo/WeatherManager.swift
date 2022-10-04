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
    @Published var api_key : String?
    
    ///  Published variable that informs of the last weather obtain.
    @Published var lastWeather : WeatherResponse = WeatherResponse(results: 0, data: [])
    
    /// Published variable that informs of the last response made from the API.
    @Published var lastResponse : URLResponse? = nil
    
    /// Published varibale that informs of, if any, last ``WeatherManagerException``  made by the ``WeatherManager``.
    @Published var lastError : Error? = nil
    
    /// Published variable that informs if the ``WeatherManager`` is making any oparation.
    @Published var isLoading  = false
    
    /// Published variable that informs if ``lastWeather`` was from `AirportWeatherCache`.
    @Published var fromCache = false
    
    /// Private realm that will be the databe for the manager, especially to use in ``iataToIcao(iata:)``and other verifications.
    private var realm : Realm?
    
    /// Initialazer that loads the database.
    init() {
        realm = loadDatabase()
        
        
        if let saveKey = UserDefaults.standard.data(forKey: "SaveAPIkey"){
            if let decoded = try? JSONDecoder().decode(String.self, from: saveKey){
                self.api_key = decoded
                return
            }
        }
        
        self.api_key = nil
        
    }
    
    /// Searches and 
    /// - Returns: `nil` if the database wasn't found, a ``Realm``otherwise.
    private func loadDatabase() -> Realm? {
        let bundle = Bundle(for: WeatherManager.self)
        let realmURL = bundle.url(forResource: "Data", withExtension: "realm")
        
        //let realmURL = Bundle.main.url(forResource: "Data", withExtension: "realm")
        
        guard let realmURL = realmURL else {
            lastError = WeatherManagerException.DataBaseNotFound
            return nil
        }
        
        var realmConfig = Realm.Configuration()
        realmConfig.seedFilePath = realmURL
        realmConfig.readOnly = true
        
    
        let realm = try! Realm(configuration: realmConfig)
        
        return realm
        
    }
    
    
    //Save the
    func saveAPIkey(){
        if let enconder = try? JSONEncoder().encode(api_key){
            UserDefaults.standard.set(enconder, forKey: "SaveAPIkey")
        }
    }
    
    /// Transform IATA codes to ICAO codes. Also updates `lastError` if an error had happen.
    /// - Parameter iata: IATA code that will be transform
    /// - Returns: `ERROR` if an error happen, if not found retorn `ICAO not found`, or the equivalent ICAO code.
    func iataToIcao(iata : String) -> String {
        guard let realm = realm else {
            lastError = WeatherManagerException.DataBaseNotFound
            return "ERROR"
        }
        if iata.count != 3 {
            lastError = WeatherManagerException.InvalidIataLenght
        }
        
        let realmObs = realm.objects(IataIcaoCodes.self)
        
        let response = realmObs.first {
            $0.IATA == iata
        }
        
        guard let response = response else {
            lastError = WeatherManagerException.ICAO_CodeNotFound
            return "ERROR"
        }
        
        return response.ICAO!
    }
    
    
    /// Get the Weather from IATA codes. Updates ``lastError`` and ``lastWeather``, dependeing of how the API response.
    /// - Parameter iata: The IATA code from the wish Airport.
    func getWeather(iata : String){
        if(iata.count != 3){
            lastError = WeatherManagerException.InvalidIataLenght
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
            lastError = WeatherManagerException.InvalidIcaoLenght
            return
        }
        
        if let cacheWeather = AirportWeatherCache[icao] {
            
            let minutesOfWeatherAntiquityThreshold = 10
            
            if cacheWeather.1.timeIntervalSinceNow < Double(-60 * minutesOfWeatherAntiquityThreshold) {
                guard api_key != nil else {
                    lastError = WeatherManagerException.NoAPIkey
                    return
                }
                fetchWeather(icao: icao)
                return
            }
            
            fromCache = true
            lastWeather = cacheWeather.0
            return
        }
        guard api_key != nil else {
            lastError = WeatherManagerException.NoAPIkey
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
        
        
        guard let api_key = api_key, api_key != "" else {
            lastError = WeatherManagerException.NoAPIkey
            isLoading = false
            return
        }
        
        guard let url =  URL(string : "https://api.checkwx.com/metar/\(icao)/decoded/?x-api-key=\(api_key)") else {
            fatalError()
        }
        
        let task = URLSession.shared.dataTask(with: url){[unowned self] data, response, error in
            
            DispatchQueue.main.async {
                self.lastWeather = WeatherResponse(results: 0, data: [])
            }
            
            let decoder = JSONDecoder()
            
            
            
            let httpResponse = response as? HTTPURLResponse
                    
            guard let httpResponse = httpResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    if error == nil{
                        self.lastError = WeatherManagerException.ErrorResponse(error: httpResponse?.statusCode.description ?? "Not found")
                    }
                    self.isLoading = false
                }
                return
            }
            
            
            
            if let data = data {
                do{
                    let resultado = try decoder.decode(WeatherResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.lastWeather = resultado
                        guard self.lastWeather.results != 0 else {
                            self.lastError = WeatherManagerException.ZeroResults
                            self.isLoading = false
                            return
                        }
                        self.AirportWeatherCache[icao] = (self.lastWeather, Date())
                    }
                    
                    
                } catch DecodingError.dataCorrupted(_){
                    DispatchQueue.main.async {
                        self.lastError = error
                    }
                }
                catch{
                    DispatchQueue.main.async {
                        self.lastError = error
                    }
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
        if lastError == nil {
            task.resume()
        }
        
    }
}
