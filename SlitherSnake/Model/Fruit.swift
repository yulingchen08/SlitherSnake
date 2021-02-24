//
//  Fruit.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/1/22.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import Foundation
import UIKit


class Fruit{
    
    
    var location: CGPoint?
    
    var maxWidth: Int
    var maxHeight: Int
       
    
    init(location: CGPoint, view: UIView) {
        maxWidth = Int(view.bounds.width) / Int(ratio)
        maxHeight = Int(view.bounds.height) / Int(ratio)
        self.location = location
    }
    
    
    func updateFruit(){
        if location != nil{
           location = CGPoint(x: Int.random(in: 0 ... (maxWidth - 1)),y: Int.random(in: 0 ... (maxHeight - 1)))
        }
        
    }
}
