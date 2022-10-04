//
//  Proyecto01Tests.swift
//  Proyecto01Tests
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import XCTest
import RealmSwift

class Proyecto01Tests: XCTestCase {
    
    
    var weatherManager : WeatherManager!

    
    override func setUp(){
        weatherManager = WeatherManager()
        weatherManager.api_key = "dd12071c43534b23a8adc8b69e" // Please put your API key here, otherwise the test will fail. This is an example.
        super.setUp()
    }
    
    func testGetWeatherIata(){
        guard weatherManager.api_key != "", weatherManager.api_key != nil else {
                XCTFail("No API key")
                return
        }
        
        weatherManager.getWeather(iata: "MEX")
        let expectation = self.expectation(description: "Wait response")
        
        DispatchQueue.global().async {
            while(true){
                if(self.weatherManager.lastWeather.results != 0){
                    expectation.fulfill()
                    break
                }
            }
        }
        
        waitForExpectations(timeout: 20)
        
        XCTAssert(weatherManager.lastWeather.data[0].icao == "MMMX", "Incorrect response")
    }
    
    
    func testGetWeatherIcao() {

        guard weatherManager.api_key != "", weatherManager.api_key != nil else {
                XCTFail("No API key")
                return
        }
        
        let expectation = self.expectation(description: "Response")
        weatherManager.getWeather(icao: "MMMX")
        
        DispatchQueue.global().async {
            while(true){
                if(self.weatherManager.lastWeather.results != 0){
                    expectation.fulfill()
                    break
                }
            }
        }
        
        waitForExpectations(timeout: 20)
        XCTAssert(self.weatherManager.lastWeather.data[0].icao == "MMMX", "Incorrect response")
        
    }
    
    
    func testIataToIcao() {
        guard weatherManager.lastError?.localizedDescription != "The Data Base wasn't found." else {
            XCTFail("Data Base not Found")
            return
        }
        XCTAssert(weatherManager.iataToIcao(iata: "MEX") == "MMMX")
        XCTAssert(weatherManager.iataToIcao(iata: "MTY") == "MMMY")
        XCTAssert(weatherManager.iataToIcao(iata: "LHR") == "EGLL")
        XCTAssert(weatherManager.iataToIcao(iata: "DXB") == "OMDB")
        XCTAssert(weatherManager.iataToIcao(iata: "LGA") == "KLGA")
        XCTAssert(weatherManager.iataToIcao(iata: "JFK") == "KJFK")
        XCTAssert(weatherManager.iataToIcao(iata: "DUB") == "EIDW")
        XCTAssert(weatherManager.iataToIcao(iata: "AMS") == "EHAM")
        XCTAssert(weatherManager.iataToIcao(iata: "CUN") == "MMUN")
    }
    

    
    
}
