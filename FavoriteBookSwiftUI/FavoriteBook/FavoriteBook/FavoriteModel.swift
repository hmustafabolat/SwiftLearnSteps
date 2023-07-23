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
let mhy = FavoritesElements(name: "Mert Hakan Yandaş", imagaName: "mhy", description: "Orta Saha Oyuncusu")
let dzeko = FavoritesElements(name: "Edin Dzeko", imagaName: "dzeko", description: "Forvet Oyuncusu")
let tadic = FavoritesElements(name: "Dusan Tadic", imagaName: "tadic", description: "Kanat Oyuncusu")

let favorites11Player = FavoriteModel(title: "Favorites 11 Player", elements: [mhy, dzeko, tadic])


//Spare
let arao = FavoritesElements(name: "Willian Arao", imagaName: "arao", description: "Defansif Orta Saha Oyuncusu")
let crespo = FavoritesElements(name: "Miguel Crespo", imagaName: "crespo", description: "Defansif Orta Saha Oyuncusu")
let osayi = FavoritesElements(name: "Bright Osayi Samuel", imagaName: "osayi", description: "Bek & Kanat Oyuncusu")

let favoritesSparesPlayer = FavoriteModel(title: "Favorites Spare Player", elements: [arao, crespo, osayi])

let myFavorites = [favorites11Player, favoritesSparesPlayer]
