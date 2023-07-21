//
//  MusicianStruct.swift
//  AdvancedSwiftProject
//
//  Created by Musti on 21.07.2023.
//

import Foundation

struct MusicianStruct{
    var name : String
    var age : Int
    var instrument : String
    
    //Struct yapıda ki bir fonksiyonu çalıştırmak için 'mutating' kullanılır.
    mutating func happBirthday(){
        self.age += 1
    }
}
