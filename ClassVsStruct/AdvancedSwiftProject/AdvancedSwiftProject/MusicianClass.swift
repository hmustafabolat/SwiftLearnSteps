//
//  MusicianClass.swift
//  AdvancedSwiftProject
//
//  Created by Musti on 21.07.2023.
//

import Foundation

class MusicianClass{
    
    var name: String
    var age: Int
    var instrument : String
    
    init(nameInput: String, ageInput: Int, instrumentInput: String) {
        self.name = nameInput
        self.age = ageInput
        self.instrument = instrumentInput
    }
    
    func happyBirthday(){
        self.age += 1
    }
    
}
