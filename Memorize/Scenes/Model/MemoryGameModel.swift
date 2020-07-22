//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Izzy on 22/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import Foundation

struct MemoryGameModel<CardContent> {
    var cards: [Card] = []
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        for index in 0..<numberOfPairs {
            let cardContent = cardContentFactory(index)
            cards.append(Card(id: index*2, content: cardContent))
            cards.append(Card(id: index*2+1, content: cardContent))
        }
        cards.shuffle()
    }
    
    func choose(card: Card) {
        print("card chosen \(card)")
    }
}

extension MemoryGameModel {
    struct Card: Identifiable {
        var id: Int
        let content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }
}
