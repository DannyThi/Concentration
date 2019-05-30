//
//  ViewController.swift
//  Concentration
//
//  Created by Thi Danny on 2019/05/28.
//  Copyright © 2019 Spawn Camping Panda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    lazy var game = newGame()
    var themes = ["animals" : ["🐢", "🐍", "🐷", "🦞", "🐇", "🐈", "🕊", "🐘", "🐃"],
                  "sports" : ["🏓", "🏒", "🏐", "🏑", "🏏", "🏀", "🥊", "🎾", "⚾️"],
                  "faces" : ["😍", "😋", "😂", "😅", "😬", "😭", "😪", "🤠", "😖"],
                  "halloween" : ["🎃", "👻", "😱", "🙀", "😈", "🍎", "🦇", "🍭", "🍬"],
                  "food" : ["🥗", "🍥", "🍧", "🍔", "🍕", "🥓", "🍖", "🥝", "🍟"],
                  "vehicles" : ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚒", "🚜"],
                  "countries" : ["🇹🇷", "🇯🇵", "🇹🇭", "🇾🇹", "🇧🇲", "🇬🇲", "🇨🇦", "🇦🇺", "🇧🇮"]]
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card not in cardButtons array.")
        }
    }
    
    @IBAction func touchedNewGame(_ sender: UIButton) {
        game = newGame()
        emojiChoices = []
        updateViewFromModel()
    }
    
    private func newGame() -> Concentration {
        return Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2,
                             theme: themes.keys.randomElement()!)
    }
    
    func updateViewFromModel() {
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emojiChoices.isEmpty, let theme = themes[game.theme] {
            emojiChoices = theme
        }
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
}

