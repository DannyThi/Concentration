//
//  ViewController.swift
//  Concentration
//
//  Created by Thi Danny on 2019/05/28.
//  Copyright © 2019 Spawn Camping Panda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            flipCountLabel.attributedText = updateFlipCountsLabel()
        }
    }
    @IBOutlet private weak var scoreLabel: UILabel!
    
    private lazy var game = newGame()
    
    private func newGame() -> Concentration {
        return Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2,
                             theme: themes.keys.randomElement()!)
    }
    
    private var themes = ["animals"     : "🐢🐍🐷🦞🐇🐈🕊🐘🐃",
                          "sports"      : "🏓🏒🏐🏑🏏🏀🥊🎾⚾️",
                          "faces"       : "😍😋😂😅😬😭😪🤠😖",
                          "halloween"   : "🎃👻😱🙀😈🍎🦇🍭🍬",
                          "food"        : "🥗🍥🍧🍔🍕🥓🍖🥝🍟",
                          "vehicles"    : "🚗🚕🚙🚌🚎🏎🚓🚒🚜",
                          "countries"   : "🇹🇷🇯🇵🇹🇭🇾🇹🇧🇲🇬🇲🇨🇦🇦🇺🇧🇮"]
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not in cardButtons array.")
        }
    }
    
    @IBAction private func touchedNewGame(_ sender: UIButton) {
        game = newGame()
        emojiChoices = ""
        updateViewFromModel()
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            } else
            {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
        
        flipCountLabel.attributedText = updateFlipCountsLabel()
    }
    
    private func updateFlipCountsLabel() -> NSAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        return attributedString
    }
    
    private var emojiChoices = ""
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emojiChoices.isEmpty, let theme = themes[game.theme] {
            emojiChoices = theme
        }
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

