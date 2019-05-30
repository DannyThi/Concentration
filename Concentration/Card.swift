//
//  Card.swift
//  Concentration
//
//  Created by Thi Danny on 2019/05/29.
//  Copyright © 2019 Spawn Camping Panda. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var wasFlipped = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
