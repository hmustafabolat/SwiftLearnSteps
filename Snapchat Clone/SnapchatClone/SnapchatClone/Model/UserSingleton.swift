//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Musti on 25.07.2023.
//

import Foundation

class UserSingleton{
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init (){
        
    }
}
