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
        var turnedOverCount: Int = 0
        
        var isFaceUp: Bool = false {
            didSet {
                isFaceUp ? startUsingBonusTime() : stopUsingBonusTime()
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        // MARK: Bonus time
        
        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUp = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUp)
            } else {
                return pastFaceUpTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
