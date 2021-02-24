//
//  RankViewController.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/2/6.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class RankViewController: UIViewController{
    
    @IBOutlet weak var trophyBackgroundView: UIView!
    
    @IBOutlet weak var RankTableView: UITableView!
    
    let viewModel = RankViewModel()
    
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        setUI()
        setTableViewDataSource()
    }
    
    
    
 
    func setUI(){
        RankTableView.register(UINib(nibName: "RankCellView", bundle: nil), forCellReuseIdentifier: "rankviewcellID")
        RankTableView.allowsSelection = false
        RankTableView.rx.setDelegate(self).disposed(by: bag)
        
    }
    
    
    
    func setTableViewDataSource(){
        Observable.just(viewModel.rank)
            .bind(to: RankTableView.rx.items){ (tableview, index, element) in
                //elemet => ([String]:[Bool]) of items
                
                
                let cell = tableview.dequeueReusableCell(withIdentifier: "rankviewcellID") as! RankCellView
                                        
                cell.rankNumberLabel.text = "\(index + 1)"
                cell.nameLabel.text = element.name!
                cell.scoreLabel.text = "\(element.score!)"
                return cell
                
        }.disposed(by: bag)
    }
    
    
        
}

extension RankViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}


