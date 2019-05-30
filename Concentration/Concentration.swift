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
    var flipCount = 0
    var score = 0
    
    var theme: String!
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index : Int) {
        if cards[index].wasFlipped {
            score -= 1
        } else {
            cards[index].wasFlipped = true
        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            } else {
                
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init(numberOfPairsOfCards: Int, theme: String) {
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
        self.theme = theme
    }
}




