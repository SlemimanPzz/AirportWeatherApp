//
//  ContentView.swift
//  Shared
//
//  Created by Emiliano Apodaca on 28/08/22.
//

import SwiftUI


enum CodePicker : String, CaseIterable{
    case IATA
    case ICAO
}


struct ContentView: View {
    @StateObject var weatherManager = WeatherManager()
    @State var codigoSolicitud =  ""
    @State var featchFallido = false
    @State var APIkeyField = ""
    @State var APIkey = ""
    @State var codePick = CodePicker.ICAO
    
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.blue,.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Airport Weather")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .padding()

                Text("Insert the airport code").bold().font(.headline)
                TextField(codePick.rawValue, text: $codigoSolicitud, prompt: Text(codePick.rawValue))
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack{
                    Text("Pick Code Type:")
                        .font(.body)
                        .padding()
                    Picker("Select the code type", selection: $codePick){
                        ForEach(CodePicker.allCases, id : \.self){ code in
                            Text(code.rawValue)
                        }.padding()
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.trailing)
                }
                
                if weatherManager.isLoading {
                    IsLoadingView()
                } else if weatherManager.lastError != nil {
                    ErrorView(erroObject: weatherManager )
                } else {
                    WeatherView(weather: weatherManager.lastWeather, fromCache: weatherManager.fromCache)
                }
                
                Spacer()
                
                TextField("Insert your API key", text: $APIkeyField, prompt: Text("API key"))
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack{
                    Button{
                        APIkey = APIkeyField
                        APIkeyField = ""
                        weatherManager.APIkey = APIkey
                    } label: {
                        Text("Save API key")
                    }
                    .padding()
                    
                    Button {
                        weatherManager.APIkey = APIkey
                        if(codePick == CodePicker.ICAO){
                            weatherManager.getWeather(icao: codigoSolicitud.description)
                        } else {
                            weatherManager.getWeather(iata: codigoSolicitud.description)
                        }
                        
                        print(codigoSolicitud)
                        
                    } label: {
                        Text("Get Weather")
                    }
                    .padding()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        ContentView(weatherManager: WeatherManager())
    }
}
