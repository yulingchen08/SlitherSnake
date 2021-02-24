//
//  MainViewController.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/2/3.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    
    
   
    @IBAction func StartGameAction(_ sender: Any) {
        
        let vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "snakeVCID") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func GoLeaderBoardAction(_ sender: Any) {
//        let vc:ViewController = UIStoryboard(name: "ViewController", bundle: nil).instantiateViewController(withIdentifier: "snakeVCID") as! ViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false, completion: nil)
        
        
        let vc:RankViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rankVCID") as! RankViewController
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    @IBAction func goNavigation(_ sender: Any) {
        
        let vc = MainNavigationViewController(nibName :"MainNavigationViewController",bundle : nil)
        let nvvc = UINavigationController(rootViewController: vc)
        
        nvvc.modalPresentationStyle = .fullScreen
        self.present(nvvc, animated: false, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        //let leaderboard = [Rank(name: "pkb", score: 100)]
        
        //let jsonString = leaderboard.arrayToJSONString()
        // UserDefaults.standard.value(forKey: "addg")
       // UserDefaults.standard.setStructArray(leaderboard, forKey: "abc")
//        let rrrank = UserDefaults.standard.structArrayData(Rank.self, forKey: "abc")
//        if rrrank.isEmpty
//        {
//            print("是nil")
//        }
    }
    
    
//    func convertIntoJSONString(arrayObject: [Any]) -> String? {
//
//        do {
//            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
//            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
//                return jsonString as String
//            }
//
//        } catch let error as NSError {
//            print("Array convertIntoJSON - \(error.description)")
//        }
//        return nil
//    }
}
