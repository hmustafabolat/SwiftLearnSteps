//
//  Router.swift
//  CryptoViper
//
//  Created by Musti on 28.07.2023.
//

import Foundation

protocol AnyRouter{
    static func StartExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter{
    
    static func StartExecution() -> AnyRouter {
        let router = CryptoRouter()
        return router
    }
}
