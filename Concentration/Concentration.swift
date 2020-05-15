//
//  Concentration.swift
//  Concentration
//
//  Created by Chase McElroy on 5/12/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    
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
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func createGame(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you passed no pairs of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            cards.shuffle()
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        createGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    func resetGame(numberOfPairsOfCards: Int) {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
