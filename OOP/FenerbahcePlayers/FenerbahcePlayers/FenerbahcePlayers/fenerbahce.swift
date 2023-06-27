//
//  fenerbahce.swift
//  FenerbahcePlayers
//
//  Created by Musti on 19.06.2023.
//

import Foundation

class Fenerbahce {
    var playerName : String = ""
    var surname : String = ""
    var age : Int = 0
    
    init(nameInit:String, surNameInit:String, ageInit:Int){
        playerName = nameInit
        surname = surNameInit
        age = ageInit
    }
    
    func shoot(){
        print("İrfan can şut attı.")
    }
}
