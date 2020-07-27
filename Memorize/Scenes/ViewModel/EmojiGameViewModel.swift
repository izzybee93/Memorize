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
    private(set) var theme: Theme

    var cards: [MemoryGameModel<Emoji>.Card] {
        gameModel.cards
    }
    
    @Published private var gameModel: MemoryGameModel<Emoji>
    
    init(theme: Theme) {
        self.theme = theme
        let cardContentFactory = EmojiCardContentFactory(theme: theme)
        gameModel = MemoryGameModel<Emoji>(numberOfPairs: cardContentFactory.contents.count, cardContentFactory: cardContentFactory.createCardContent)
    }
    
    func choose(card: MemoryGameModel<Emoji>.Card) {
        gameModel.choose(card: card)
    }
    
    func startNewGame(theme: Theme = Theme.random) {
        self.theme = theme
        let cardContentFactory = EmojiCardContentFactory(theme: theme)
        gameModel = MemoryGameModel<Emoji>(numberOfPairs: cardContentFactory.contents.count, cardContentFactory: cardContentFactory.createCardContent)
    }
}
