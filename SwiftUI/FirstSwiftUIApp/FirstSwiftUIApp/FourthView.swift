//
//  FourthView.swift
//  FirstSwiftUIApp
//
//  Created by Musti on 23.07.2023.
//

import SwiftUI

struct FourthView: View {
    
    @State var myName = "Musti"
    
    var body: some View {
        VStack{
            Text(myName).font(.largeTitle).padding()
            Button(action: {self.myName = "James"}){
                Text("My Button")
            }
        }
    }
    
    struct FourthView_Previews: PreviewProvider {
        static var previews: some View {
            FourthView()
        }
    }
}
