//
//  ViewController.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/1/22.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit
import RxCocoa
import RxGesture
import RxSwift

class ViewController: UIViewController {

    
    var viewModel: SnakeViewModel! = nil
    var bag = DisposeBag()
    
    @IBOutlet weak var snakeView: SnakeView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //snakeView.refreshView(snake:viewModel.snake!, fruit:viewModel.fruit!)
        //viewModel.initModel(point: CGPoint(x: self.view.center.x, y: self.view.center.y))
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  gameOverAlert()
    }
    
    
    func bindViewModel(){
        viewModel = SnakeViewModel(view: snakeView)
        
        
        viewModel.scoreObservable
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe( onNext:{ [unowned self] value in
                self.scoreLabel.text = "\(value)"
        }).disposed(by: bag)
        
       
        
        viewModel.snakeLocations
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe( onNext:{ [unowned self] locations in
                self.snakeView.updateSnake(locations: locations)
            }).disposed(by: bag)
        
        viewModel.fruitLocation
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe( onNext:{ [unowned self] location in
                self.snakeView.updateFruit(location: location)
            }).disposed(by: bag)
        
        viewModel.gameOverObservable
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe( onNext:{ [unowned self] _ in
                self.gameOverAlert()

            }).disposed(by: bag)
        
        
        snakeView.rx
            .swipeGesture([.up, .down, .left, .right])
            .when(.recognized)
            .subscribe(onNext:{ [unowned self] gesture in
                self.viewModel.swipeGesture(gesture: gesture)
            }).disposed(by: bag)
        
            
       
    }
    
    
    
    func gameOverAlert() {
        //Step : 1
        let alert = UIAlertController(title: "Game Over", message: "Please enter your name.", preferredStyle: UIAlertController.Style.alert )
        //Step : 2
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            print("Press Save")
            var newName = "No name"
            if textField.text != "" {
                //Read TextFields text data
                newName = textField.text!
            }
            
            if let current_score = self.scoreLabel.text{
                if self.viewModel!.isShownOnLeaderBoard(score: Int(current_score)!){
                    //save score to udserdefault and present leaderboard
                    self.viewModel!.ranking(newRank: Rank(name: newName, score: Int(current_score)!))
                }else{
                    self.dismiss(animated: false, completion: nil)
                }
            }else{
                self.dismiss(animated: false, completion: nil)
            }
        }

        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your first name"
            textField.textColor = .red
        }
        //For second TF
//        alert.addTextField { (textField) in
//            textField.placeholder = "Enter your last name"
//            textField.textColor = .blue
//        }

        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
            self.dismiss(animated: false, completion: nil)
        }
        alert.addAction(cancel)
        //OR single line action
        //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })

        self.present(alert, animated:true, completion: nil)

    }
    

    
    
    
    
}

