//
//  ContentView.swift
//  FenerbahcePlayerList
//
//  Created by Musti on 24.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                ForEach(myPlayerList) {player in
                    Section(header: Text(player.title)){
                        ForEach(player.elements){element in
                            NavigationLink(destination: DetailsView(chosenFavoriteElement: element)) {
                                Text(element.name)
                            }
                        }
                    }
                }.navigationBarTitle(Text("Player Info Book"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
