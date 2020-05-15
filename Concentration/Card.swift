//
//  Card.swift
//  Concentration
//
//  Created by Chase McElroy on 5/12/20.
//  Copyright © 2020 ChaseMcElroy. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    private(set) var identifier: Int

    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    
}
