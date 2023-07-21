//
//  main.swift
//  AdvancedSwiftProject
//
//  Created by Musti on 21.07.2023.
//

import Foundation

let classJames = MusicianClass(nameInput: "Muti", ageInput: 24, instrumentInput: "Guitar")
print(classJames.age)

var structJames = MusicianStruct(name: "Muti", age: 30, instrument: "Guitar")
print(structJames.name)

//IMMUTABLE STRUCT
//Burada yaşlarda güncelleme yapıldığında sadece 'Class' yapısında değişim olacaktır. Çünkü Class tanımlaması yaparken let ile tanımladık güncellemeyi açtık fakat 'Struct' yapısında bu güncellemeyi 'let' ile değilde 'var' ile yapabiliyoruz.
classJames.age = 25
//print(classJames.age)

structJames.age = 31
//print(structJames.age)

//REFERENCE VS VALUE

let copyOfClassName = classJames
var copyOfStructName = structJames

//print(copyOfClassName.name)
//print(copyOfStructName.name)

copyOfClassName.name = "Muti 2"
copyOfStructName.name = "Muti 3"

//print(copyOfClassName.name)
//print(copyOfStructName.name)

//print(classJames.name)
//print(structJames.name)

print(classJames.age)
classJames.happyBirthday()
print(classJames.age)

print(structJames.age)
structJames.happBirthday()
print(structJames.age)

//TUPLE

let myTuple = (1,3)
print(myTuple.1)

var myTuple2 = (1,5,3,6,2,0)
myTuple2.1 = 10
print(myTuple2.1)

let myTuple3 = (10,[39,40])
print(myTuple3.1[1])


//GUARD LET VS IF LET

//Guard daha çok değilse gibisinden işlemleri kullanır yani --> Olumsuz
//If ise daha çok öyleyse yap gibisinden işlemlerde kullanılır --> Olumlu

let myNumber = "Apple"

func convertToIntegerGuard(stringInput : String) -> Int{
    // "guard let" ifadesi, stringInput parametresini tamsayıya dönüştürmeye çalışır.
    // Eğer dönüştürme başarılı olursa, myInteger'a atanır ve nil olmayan bir değeri elde ederiz.
    // Eğer dönüştürme başarısız olursa, yani stringInput, tamsayıya dönüştürülemez bir değer içeriyorsa, fonksiyon "return 0" ifadesiyle sonlanır ve 0 değeri döndürülür.
    
    guard let myInteger = Int(stringInput) else {
        guard let myInteger = Int(stringInput) else {return 0}
        
        // "guard let" ifadesi başarılı olduğu durumda buraya ulaşılır ve myInteger değeri nil olmayan bir tamsayı değerine sahiptir.
        
        return myInteger
    }
    
    //If-let
    
    func convertToIntegerIf(stringInput : String) -> Int {
        // "if let" ifadesi, stringInput parametresini tamsayıya dönüştürmeye çalışır.
        // Eğer dönüştürme başarılı olursa, myInteger'a atanır ve nil olmayan bir değeri elde ederiz.
        if let myInteger = Int(stringInput){
            // "if let" ifadesi başarılı olduğu durumda buraya ulaşılır ve myInteger değeri nil olmayan bir tamsayı değerine sahiptir.
            return myInteger
        }else{
            // Eğer dönüştürme başarısız olursa, yani stringInput, tamsayıya dönüştürülemez bir değer içeriyorsa, fonksiyon "return 0" ifadesiyle sonlanır ve 0 değeri döndürülür.
            return 0
        }
        
    }
    print (convertToIntegerIf(stringInput: myNumber))
    print (convertToIntegerGuard (stringInput: myNumber))


    }

