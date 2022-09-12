//
//  Proyecto01Tests.swift
//  Proyecto01Tests
//
//  Created by Emiliano Apodaca on 04/09/22.
//

import XCTest

class Proyecto01Tests: XCTestCase {
    
    
    var weatherManager : WeatherManager!

    
    
    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var weatherManager = WeatherManager()
        super.setUp()
    }
    
    
    
    
    
    func testIataToIcao() {
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
