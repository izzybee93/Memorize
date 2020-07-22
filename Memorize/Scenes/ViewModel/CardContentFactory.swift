//
//  CardContentFactory.swift
//  Memorize
//
//  Created by Izzy on 22/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import Foundation

protocol CardContentFactory {
    associatedtype CardContent
    
    var contents: [CardContent] { get }
    func createCardContent(at index: Int) -> CardContent
}

struct EmojiCardContentFactory: CardContentFactory {
    typealias CardContent = Emoji
    
    let contents: [CardContent] = generateEmojis()
    
    func createCardContent(at index: Int) -> CardContent {
        guard index < contents.count else {
            assertionFailure()
            return ""
        }
        return contents[index]
    }
    
    private static func generateEmojis() -> [CardContent] {
        var emojis = ["👻", "🎃", "🕷", "👹", "💀", "🕸", "👽", "🧟‍♂️", "🐺", "🍬"]
        
        let numberOfPairs = Int.random(in: 2...emojis.count)
        var selectedEmojis: [CardContent] = []
        
        for _ in 0..<numberOfPairs {
            guard let emoji = emojis.randomElement() else { break }
            selectedEmojis.append(emoji)
            guard let selectedIndex = emojis.firstIndex(of: emoji) else { break }
            emojis.remove(at: selectedIndex)
        }
        
        print("number of pairs: \(numberOfPairs)")
        print(selectedEmojis)
        return selectedEmojis
    }
}
