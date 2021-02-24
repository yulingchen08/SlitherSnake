//
//  RankViewModel.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/2/6.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class RankViewModel{
    
    var rank: [Rank]
    
    init() {
        rank = UserDefaults.standard.structArrayData(Rank.self, forKey: USERDEFAULT_LEADERBOARD)
    }
    
    
    
    
    
    
}
