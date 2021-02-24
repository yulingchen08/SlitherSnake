//
//  Snake.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/1/22.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Direction {
    case up
    case down
    case right
    case left
}

class Snake{
    
    var locations: Array<CGPoint>?
    var direction: Direction = .up
    var maxWidth: Int
    var maxHeight: Int
    let gameoverSignal = PublishSubject<Void>()
    
    
    init(view: UIView){
        maxWidth = Int(view.bounds.width) / Int(ratio)
        maxHeight = Int(view.bounds.height) / Int(ratio)
        
        let centerX = Int(view.bounds.width) / Int(ratio) / 2
        let centerY = Int(view.bounds.height) / Int(ratio) / 2
        
        self.locations = [CGPoint(x: centerX, y: centerY), CGPoint(x: centerX , y: centerY + 1), CGPoint(x: centerX , y: centerY + 2), CGPoint(x: centerX , y: centerY + 3)]
    }
    
    func getSnakeQueue() -> Array<CGPoint>{
        locations!
    }
    
    func changeDirection(dir: Direction){
        
        if dir == .up && direction != .down || dir == .down && direction != .up || dir == .right && direction != .left || dir == .left && direction != .right{
            direction = dir
        }
    }
    
    func move(){
        
        if locations != nil{            
            let firstNode = locations!.first!
            locations!.removeLast()
            
            switch direction {
            case .up:
                locations!.insert(CGPoint(x: firstNode.x, y: firstNode.y - 1), at: 0)
            case .down:
                locations!.insert(CGPoint(x: firstNode.x, y: firstNode.y + 1), at: 0)
            case .right:
                locations!.insert(CGPoint(x: firstNode.x + 1, y: firstNode.y), at: 0)
            case .left:
                locations!.insert(CGPoint(x: firstNode.x - 1, y: firstNode.y), at: 0)
        
            }
                        
            checkTouchBoundary()

                    
        }
        

        
    }
    
    func checkTouchBoundary(){
        
        if locations != nil{
            for node in locations!{
                if node.x < 0{
                    locations![0] = CGPoint(x: node.x + CGFloat(maxWidth), y: node.y)
                }else if node.x > CGFloat(maxWidth - 1){
                    locations![0] = CGPoint(x: node.x - CGFloat(maxWidth), y: node.y)
                }
                
                if node.y < 0{
                    locations![0] = CGPoint(x: node.x, y: node.y + CGFloat(maxHeight))
                }else if node.y > CGFloat(maxHeight - 1){
                    locations![0] = CGPoint(x: node.x, y: node.y - CGFloat(maxHeight))
                }
            }
            
            
        }
        
        
    }
    

    private func addBody(){
       
        if locations != nil{
            let lastNode = locations!.last!
            let lastSecond = locations![locations!.count - 2]
            if lastNode.x == lastSecond.x  && lastNode.y > lastSecond.y{
                //upforward
                locations!.append(CGPoint(x: lastNode.x, y: lastNode.y + 1))
            }else if lastNode.x == lastSecond.x && lastNode.y < lastSecond.y{
                //downforward
                locations!.append(CGPoint(x: lastNode.x, y: lastNode.y - 1))
            }else if lastNode.y == lastSecond.y && lastNode.x > lastSecond.x{
                //leftforward
                locations!.append(CGPoint(x: lastNode.x + 1, y: lastNode.y))
            }else if lastNode.y == lastSecond.y && lastNode.x < lastSecond.x{
                //rightforward
                locations!.append(CGPoint(x: lastNode.x - 1, y: lastNode.y))
            }
            
            
        }
       
    }
    
    
    func checkIfEating(fruitNode: CGPoint) -> Bool{
        guard let locations = self.locations else{
            return false
        }
        
        guard let firstNode = locations.first else{
            return false
        }
        print("firstNode: \(firstNode), fruit: \(fruitNode)")
        if firstNode == fruitNode{
            print("Eating fruit now!!!")
            addBody()
            return true
        }
        return false
    }
        
    
    func checkBodyContact(){
        guard var mLocations = locations else{
            print("\(#function), locations is null")
            return
        }
        let firstNode = mLocations[0]
        mLocations.removeFirst()
        if mLocations.contains(firstNode){
            gameoverSignal.onNext(())
        }
            
        
    }
    
    func isAt(point: CGPoint) -> Bool{
        guard let mLocations = locations else{
            print("\(#function), locations is null")
            return false
        }
        let firstNode = mLocations[0]
        if point.equalTo(firstNode){
            return true
        }
        return false
        
    }
    
}
