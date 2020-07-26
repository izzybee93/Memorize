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
    
    mutating func choose(card: Card) {
        let cardIndex = index(of: card)
        cards[cardIndex].isFaceUp.toggle()
    }
    
    private func index(of card: Card) -> Int {
        let cardIndex = cards.firstIndex { $0 == card }
        guard let index = cardIndex else {
            fatalError("Card not found 🥀")
        }
        return index
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

extension MemoryGameModel.Card {
    static func == (lhs: MemoryGameModel.Card, rhs: MemoryGameModel.Card) -> Bool {
        return lhs.id == rhs.id
    }
}
