//
//  Webservices.swift
//  CryptoCrazy
//
//  Created by Musti on 27.07.2023.
//

import Foundation


class Webservice{
    
    func downloadCurrencies(url: URL, completion: @escaping([CryptoCurrency]?) -> ()){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
                //Bütün veri işlemleri burdan dönüyor
                let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                print(cryptoList)
                if let cryptoList = cryptoList{ completion(cryptoList)
                }
            }
            //resume işlemi başlatmamıza olanak tanıyan yapı.
        }.resume()
    }
}
