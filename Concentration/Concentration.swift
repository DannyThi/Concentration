//
//  Concentration.swift
//  Concentration
//
//  Created by Thi Danny on 2019/05/29.
//  Copyright © 2019 Spawn Camping Panda. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    func chooseCard(at index : Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0 ..< numberOfPairsOfCards {
            cards += [Card(), Card()]
        }
        
        // TODO: Shuffle cards
        cards.shuffle()
    }
}




