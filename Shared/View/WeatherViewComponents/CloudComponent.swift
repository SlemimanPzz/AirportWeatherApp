//
//  CloudComponent.swift
//  Proyecto01
//
//  Created by Emiliano Apodaca on 09/09/22.
//

import SwiftUI

/// View that displays the clouds, needs a ``Clouds`` array, else says that it could get them.
struct CloudComponent: View {
    
    /// Clouds of the view.
    let clouds : [Clouds]?
    
    /// Body of the view.
    var body: some View {
        if let clouds = clouds {
            VStack(alignment : .center){
                Text("Clouds")
                Text("Code :  \(clouds[0].code)")
                
                Text("Sky description : \(clouds[0].text)")
            }
            
        } else {
            VStack{
                Text("Counldn't get the clouds")
            }
        }
    }
}


/// Preview of  ``WindComponent``.
struct CloudComponent_Previews: PreviewProvider {
    static var previews: some View {
        CloudComponent(clouds: [Clouds(code: "CLR", text: "Clear")])
    }
}
