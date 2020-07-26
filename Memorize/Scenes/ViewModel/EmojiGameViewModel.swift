//
//  EmojiGameViewModel.swift
//  Memorize
//
//  Created by Izzy on 22/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import Foundation

typealias Emoji = String

final class EmojiGameViewModel: ObservableObject {
    var cards: [MemoryGameModel<Emoji>.Card] {
        gameModel.cards
    }
    
    @Published private var gameModel: MemoryGameModel<Emoji>
    
    init(cardContentFactory: EmojiCardContentFactory = EmojiCardContentFactory()) {
        gameModel = MemoryGameModel<Emoji>(numberOfPairs: cardContentFactory.contents.count, cardContentFactory: cardContentFactory.createCardContent)
    }
    
    func choose(card: MemoryGameModel<Emoji>.Card) {
        gameModel.choose(card: card)
    }
}

extension EmojiGameViewModel {
    struct CardRow: Identifiable {
        let id: Int
        let cards: [MemoryGameModel<Emoji>.Card]
    }
}

