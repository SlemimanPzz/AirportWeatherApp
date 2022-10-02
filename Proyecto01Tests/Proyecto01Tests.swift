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
        super.setUp()
    }
    
    
    override func tearDown() {
        weatherManager = nil
        super.tearDown()
    }
    
    func testGetWeatherIata(){
        weatherManager.getWeather(iata: "MEX")
        XCTAssert(weatherManager.lastError != nil)
        guard weatherManager.lastWeather.data.count >= 1 else {
            XCTAssert(false)
            return
        }
        XCTAssert(weatherManager.lastWeather.data[0].icao == "MMMX")
    }
    
    
    func testGetWeatherIcao() {

        weatherManager.getWeather(icao: "MMMX")
        XCTAssert(weatherManager.lastError != nil)
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssert(weatherManager.lastWeather.data.count > 0)
        } else {
            XCTFail("Delay interrupted")
        }
        guard weatherManager.lastWeather.data.count > 0 else {
            XCTFail()
            return
        }
        XCTAssert(weatherManager.lastWeather.data[0].icao == "MMMX")
        
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
