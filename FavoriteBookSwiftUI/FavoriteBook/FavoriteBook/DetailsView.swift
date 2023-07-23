//
//  DetailsView.swift
//  FavoriteBook
//
//  Created by Musti on 24.07.2023.
//

import SwiftUI

struct DetailsView: View {
    
    var chosenFavoriteElement : FavoritesElements
    
    var body: some View {
        VStack{
            Image(chosenFavoriteElement.imagaName).resizable().aspectRatio(contentMode: .fit)
            Text(chosenFavoriteElement.name).font(.largeTitle).padding().bold()
            Text(chosenFavoriteElement.description).font(.title2).foregroundColor(.blue)
            
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(chosenFavoriteElement: arao)
    }
}
