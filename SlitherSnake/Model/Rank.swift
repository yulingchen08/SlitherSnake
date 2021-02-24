//
//  Rank.swift
//  SlitherSnake
//
//  Created by Yu-Ling Chen on 2020/2/4.
//  Copyright © 2020 Yu-Ling Chen. All rights reserved.
//

import UIKit

struct Rank: Comparable, Codable {
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        if lhs.score != rhs.score {
            return lhs.score! < rhs.score!
        } else {
            return lhs.score! < rhs.score!
        }
    }

    let name: String?
    let score: Int?


    init(name: String, score: Int = 0) {
        self.name = name
        self.score = score
    }

    
}

