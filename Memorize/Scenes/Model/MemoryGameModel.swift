//
//  MemoryGameModel.swift
//  Memorize
//
//  Created by Izzy on 22/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    private(set) var score: Int = 0
    
    private var faceUpCardIndex: Int? {
        get {
            let faceUpCards = cards.filter { $0.isFaceUp }
            guard faceUpCards.count == 1 else { return nil }
            return cards.index(of: faceUpCards.first!)
        }
        set {
            cards.indices.forEach {
                cards[$0].isFaceUp = $0 == newValue
            }
        }
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        for index in 0..<numberOfPairs {
            let cardContent = cardContentFactory(index)
            cards.append(Card(id: index*2, content: cardContent))
            cards.append(Card(id: index*2+1, content: cardContent))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        guard let chosenIndex = cards.index(of: card) else { return }
        cards[chosenIndex].turnedOverCount += 1

        if
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = faceUpCardIndex {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                    print("Matched \(cards[chosenIndex]) \(cards[potentialMatchIndex])")
                } else {
                    if cards[chosenIndex].turnedOverCount > 1 {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                faceUpCardIndex = chosenIndex
            }
        }
    }
}

extension MemoryGameModel {
    struct Card: Identifiable {
        var id: Int
        let content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var turnedOverCount: Int = 0
    }
}
