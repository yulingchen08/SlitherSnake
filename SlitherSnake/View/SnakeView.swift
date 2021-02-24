//
//  SnakeView.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/1/31.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit

class SnakeView: UIView{
    
    var view_snake: Array<CGPoint>?
    var view_fruit: CGPoint?
    
    
    func renewView() {
        view_snake = nil
        view_fruit = nil
        setNeedsDisplay()
    }
    
    func updateSnake(locations: Array<CGPoint>){
        view_snake = locations
        setNeedsDisplay()
    }
    
    func updateFruit(location: CGPoint){
        view_fruit = location
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let aSnake = view_snake else{
            print("\(#function), snakeQueue is null")
            return
        }
        
        guard let aFruit = view_fruit else{
            print("\(#function), fruitQueue is null")
            return
        }
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        let center = CGPoint(x: aFruit.x * ratio + circleOffset, y: aFruit.y * ratio + circleOffset)
        context.addArc(center: center, radius: circleRadius, startAngle: 0, endAngle: 90, clockwise: false)
        context.setFillColor(UIColor.green.cgColor)
        context.fillPath()

        for asnake in aSnake{
                                    
            context.addRect(CGRect(x: asnake.x * ratio , y: asnake.y * ratio, width: 1 * ratio, height: 1 * ratio))
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        }
        
        
    }
    
    
    
    
    
    
    
}
