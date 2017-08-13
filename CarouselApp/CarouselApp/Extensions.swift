//
//  Extensions.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 12/08/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//

extension Float {
    func roundToInt() -> Int{
        let value = Int(self)
        let f = self - Float(value)
        if f < 0.5{
            return value
        } else {
            return value + 1
        }
    }
    
    func roundUp() -> Int {
        let value = Int(self)
        let f = self - Float(value)
        if f > 0{
            return value + 1
        } else {
            return value
        }
    }
}
