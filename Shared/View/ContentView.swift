//
//  ContentView.swift
//  Shared
//
//  Created by Emiliano Apodaca on 28/08/22.
//

import SwiftUI


/// Code picker for the user to select to make the weather requests.
enum CodePicker : String, CaseIterable{
    
    /// `IATA` code.
    case IATA
    
    /// `ICAO` code.
    case ICAO
}



/// Principal view of the App, here the user insert their API key, and the Airport code to make the request with.
struct ContentView: View {
    /// Main ``WeatherManager`` that will be used.
    @StateObject var weatherManager = WeatherManager()
    
    /// Request code,  `ICAO` or `IATA`, from which a request will be made.
    @State var requestCode =  ""
    
    /// API key used for user input.
    @State var APIkeyField = ""
    
    /// API key that will be pass to ``weatherManager``
    @State var API_key = ""
    
    /// The type of code the request will be made.
    @State var codePick = CodePicker.ICAO
    
    
    @State var saveAPIkeyAlert = false
    
    /// Body of the view.
    var body: some View {
        ZStack{
           
            if #available(iOS 15, *){
                if(ProcessInfo.processInfo.isiOSAppOnMac){
    
                } else{
                LinearGradient(gradient: Gradient(colors: [.blue,.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                }
            }
            
            
            VStack {
                ScrollView{
                    
                
                Text("Airport Weather")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .padding()

                Text("Insert the airport code").bold().font(.headline)
                TextField(codePick.rawValue, text: $requestCode, prompt: Text(codePick.rawValue))
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
                    WeatherView(weather: weatherManager.lastWeather)
                }
                
                Spacer()
                
                TextField("Insert your API key", text: $APIkeyField, prompt: Text("API key"))
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack{
                    Button{
                        saveAPIkeuUI()
                    } label: {
                        Text("Save API key")
                    }
                    .onSubmit {
                        saveAPIkeuUI()
                    }
                    .alert("Your API key(\(API_key)) has been saved.", isPresented: $saveAPIkeyAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    .padding()
                    
                    Button {
                        weatherManager.api_key = API_key
                        if(codePick == CodePicker.ICAO){
                            weatherManager.getWeather(icao: requestCode.description.uppercased())
                        } else {
                            weatherManager.getWeather(iata: requestCode.description.uppercased())
                        }
                        
                    } label: {
                        Text("Get Weather")
                    }
                    .padding()
                }
            
                }
            }
        }
    }
    
    
    /// Save the API for the manager and the UI
    func saveAPIkeuUI(){
        API_key = APIkeyField
        APIkeyField = ""
        weatherManager.api_key = API_key
        weatherManager.saveAPIkey()
        saveAPIkeyAlert = true
    }
    
    
    
}


/// Preview of ``ContentView``
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherManager: WeatherManager())
    }
}
