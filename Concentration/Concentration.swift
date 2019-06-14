//
//  Concentration.swift
//  Concentration
//
//  Created by Thi Danny on 2019/05/29.
//  Copyright © 2019 Spawn Camping Panda. All rights reserved.
//

import Foundation

struct Concentration {
    
    private (set) var cards = [Card]()
    var flipCount = 0
    private (set) var score = 0
    
    private(set) var theme: String!
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index : Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in cards.")
        
        if cards[index].wasFlipped {
            score -= 1
        } else {
            cards[index].wasFlipped = true
        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, theme: String) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): You must have at least one pair of cards.")
        
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
        self.theme = theme
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}




