//
//  secondView.swift
//  FirstSwiftUIApp
//
//  Created by Musti on 22.07.2023.
//


import SwiftUI

struct secondView: View {
    var body: some View {
        VStack{
            Image("fb").resizable().aspectRatio(contentMode: .fit).frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
            Text("İsmail Kartal").padding(.top)
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
        }}
}

struct secondView_Previews: PreviewProvider {
    static var previews: some View {
        secondView()
    }
}
