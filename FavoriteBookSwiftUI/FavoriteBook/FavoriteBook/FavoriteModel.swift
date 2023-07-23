//
//  FavoriteModel.swift
//  FavoriteBook
//
//  Created by Musti on 23.07.2023.
//

import Foundation
import SwiftUI

struct FavoriteModel : Identifiable{
    var id = UUID()
    var title : String
    var elements : [FavoritesElements]
}

struct FavoritesElements : Identifiable{
    var id = UUID()
    var name : String
    var imagaName : String
    var description : String
}
 
//11
let mhy = FavoritesElements(name: "MHY", imagaName: "mhy", description: "Mert Hakan Yandaş")
let dzeko = FavoritesElements(name: "Dzeko", imagaName: "dzeko", description: "Edin Dzeko")
let tadic = FavoritesElements(name: "Tadic", imagaName: "tadic", description: "Dusan Tadic")

let favorites11Player = FavoriteModel(title: "Favorites 11 Player", elements: [mhy, dzeko, tadic])


//Spare
let arao = FavoritesElements(name: "Arao", imagaName: "arao", description: "Willian Arao")
let osayi = FavoritesElements(name: "Osayi", imagaName: "osayi", description: "Osayi Samuel")
let crespo = FavoritesElements(name: "Crespo", imagaName: "crespo", description: "Crespo")

let favoritesSparePlayer = FavoriteModel(title: "Favorites Spare Player", elements: [arao, osayi, crespo])

let myFavorites = [favorites11Player, favoritesSparePlayer]
