//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Chase McElroy on 5/12/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 { didSet { updateFlipCountLabel() } }
    
    @IBOutlet weak var createNewGameButton: UIButton!
    
    let attributes: [NSAttributedString.Key: Any] = [
        .strokeWidth: 5.0,
        .strokeColor: UIColor.blue
    ]
    
    @IBAction func createNewGame(_ sender: UIButton) {
        flipCount = 0
        game.resetGame(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    private func updateFlipCountLabel() {
        let attributedNewGameString = NSAttributedString(string: "New Game", attributes: attributes)
        createNewGameButton.setAttributedTitle(attributedNewGameString, for: .normal)
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel() {
        guard cardButtons != nil else {return}
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emojiDict = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    
    private var emojiDict = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emojiDict[card.identifier] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emojiDict[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emojiDict[card.identifier] ?? "?"
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

