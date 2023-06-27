//
//  SuperFenerbahce.swift
//  FenerbahcePlayers
//
//  Created by Musti on 19.06.2023.
//

import Foundation


class SuperFenerbahce : Fenerbahce{
    func powerShoot(){
        print("İrfancan güçlü şut attı")
    }
    
    override func shoot() {
        super.shoot()
        print("Daha güçlü şu atıldı.")
    }
}
