//
//  SnakeViewModel.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/1/22.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Combine



class SnakeViewModel{
    
    var snake: Snake?
    var fruit: Fruit?
    
    var score = 0
    var movingObservable: Disposable?
    let snakeLocations = BehaviorRelay<[CGPoint]>(value: [])
    let fruitLocation = BehaviorRelay<CGPoint>(value: CGPoint(x:300, y: 200))
    let scoreObservable = BehaviorRelay<Int>(value: 0)
    let gameOverObservable = PublishSubject<Void>()
    
    var bag = DisposeBag()
    
    init(view: UIView){
        snake = Snake(view: view)
        
        let maxWidth = Int(view.bounds.width) / Int(ratio)
        let maxHeight = Int(view.bounds.height) / Int(ratio)
        
        fruit = Fruit(location: CGPoint(x: Int.random(in: 0 ... (maxWidth - 1)), y: Int.random(in: 0 ... (maxHeight - 1))), view:view)
        
        snakeLocations.accept(snake!.getSnakeQueue())
        
        if movingObservable == nil{
            self.movingObservable = createMovingTimer()
        }
        
        
        snake?.gameoverSignal.subscribe(onNext:{ [unowned self] _ in
            print("Game Over")
            self.movingObservable?.dispose()
            self.gameOverObservable.onNext(())
        }).disposed(by: bag)
                
    }

    deinit {
        bag = DisposeBag()
    }

   
    
    func createMovingTimer() -> Disposable{
        
        return Observable<Int>.interval(moveRate, scheduler: SerialDispatchQueueScheduler(qos: .background))
        .subscribe(onNext:{ [unowned self] _ in
            
            guard let snake = self.snake else{
                return
            }
            
            guard let fruit = self.fruit else{
                return
            }
            
            snake.move()
            
            self.snakeLocations.accept(snake.getSnakeQueue())
            self.fruitLocation.accept(fruit.location!)
            
            if snake.checkIfEating(fruitNode: fruit.location!){
                //eating fruit
                self.score += 100
                self.scoreObservable.accept(self.score)
                fruit.updateFruit()
            }
            
            self.snake?.checkBodyContact()
            
        })
        
    }

    
    func swipeGesture(gesture: UISwipeGestureRecognizer){
        guard let snake = self.snake else{
            return
        }
        print("\(#function), \(gesture.direction)")
        switch gesture.direction {
            case .up:
            snake.changeDirection(dir: .up)
            case .down:
                snake.changeDirection(dir: .down)
            case .right:
                snake.changeDirection(dir: .right)
            case .left:
                snake.changeDirection(dir: .left)
            default:
                break
        }
        
    }
    
    func getFinalScore() -> Int{
        return score
    }
    
    
    func isShownOnLeaderBoard(score: Int) -> Bool{
        print("\(#function)")
        
        let leaderboard = UserDefaults.standard.structArrayData(Rank.self, forKey: USERDEFAULT_LEADERBOARD)
        
        if(!leaderboard.isEmpty){
            
            if leaderboard.count < billboardSize{
                print("true 1")
                return true
            }
            
            if leaderboard.last!.score! < score{
                print("true 2")
                return true
            }
            print("false 1")
            return false
            
        }
        print("true 3")
        return true
        
    }
    
    func ranking(newRank: Rank){
        
        var leaderboard = UserDefaults.standard.structArrayData(Rank.self, forKey: USERDEFAULT_LEADERBOARD)
        if (!leaderboard.isEmpty){
            
            for i in 0..<leaderboard.count{
                if newRank > leaderboard[i]{
                    leaderboard.insert(newRank, at: i)
                    break
                }
            }
                       
            if leaderboard.count > 20{
                leaderboard.removeLast()
            }
            UserDefaults.standard.setStructArray(leaderboard, forKey: USERDEFAULT_LEADERBOARD)
            print("append a rank: \(leaderboard)")
            //TODO: present rank
        }else{
            
            let leaderboard = [newRank]
            UserDefaults.standard.setStructArray(leaderboard, forKey: USERDEFAULT_LEADERBOARD)
            print("add the first rank: \(leaderboard)")
            //TODO: present rank
        }

        
    }
    
    
    
}



enum WeatherError: Error{
    case thingJustHappen
}
