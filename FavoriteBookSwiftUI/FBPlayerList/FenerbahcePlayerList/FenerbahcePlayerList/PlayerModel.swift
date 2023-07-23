//
//  PlayerModel.swift
//  FenerbahcePlayerList
//
//  Created by Musti on 24.07.2023.
//

import Foundation
import SwiftUI

struct PlayerInfo : Identifiable{
    var id = UUID()
    var title : String
    var elements : [PlayerElements]
}

struct PlayerElements : Identifiable{
    var id = UUID()
    var name : String
    var imageName : String
    var description : String
}

//11
let dzeko = PlayerElements(name: "Edin Dzeko", imageName: "dzeko", description: "Santrafor Oyuncusu")
let tadic = PlayerElements(name: "Dusan Tadic", imageName: "tadic", description: "Kanat Oyuncusu")
let osayi = PlayerElements(name: "Osayi Samuel", imageName: "osayi", description: "Kanat Oyuncusu")

let favoritesElevenPlayer = PlayerInfo(title: "Favorites 11 Player", elements: [dzeko, tadic, osayi])

//Spare Player
let arao = PlayerElements(name: "Willian Arao", imageName: "arao", description: "Orta Saha Oyuncusu")
let crespo = PlayerElements(name: "Miguel Crespo", imageName: "crespo", description: "Orta Saha Oyuncusu")
let mhy = PlayerElements(name: "Mert Hakan Yandaş", imageName: "mhy", description: "Orta Saha Oyuncusu")

let favoritesSparePlayer = PlayerInfo(title: "Favorite Spare Player", elements: [arao, crespo, mhy])

let myPlayerList = [favoritesElevenPlayer, favoritesSparePlayer]
