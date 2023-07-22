//
//  ThirdView.swift
//  FirstSwiftUIApp
//
//  Created by Musti on 23.07.2023.
//

import SwiftUI

struct ThirdView: View {
    
    let myArray = ["James", "Lars", "Kirk", "Rob"]
    
    var body: some View {
        
        
        List (myArray, id: \.self){element in
            
            Image("fb").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30)
            Text(element).font(.title3)
        }
        
        
        
        /*
        List{
            ForEach(myArray, id: \.self) {element in
                Text(element)
            }
         
        }
         */
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
