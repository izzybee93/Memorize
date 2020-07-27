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
    
    init(theme: Theme)
    func createCardContent(at index: Int) -> CardContent
}

enum Theme: String, CaseIterable {
    case halloween
    case summer
    case winter
    case animals
    case food
    case party
    
    static var random: Theme {
        let randomIndex = Int.random(in: 0...Theme.allCases.count-1)
        return Theme.allCases[randomIndex]
    }
}

struct EmojiCardContentFactory: CardContentFactory {
    typealias CardContent = Emoji
    
    private let emojiLookup: [Theme: [Emoji]] = {
        [.halloween: ["👻", "🎃", "🕷", "👹", "💀", "🕸", "👽", "🧟‍♂️", "🐺", "🍬"],
         .animals: ["🐙", "🐵", "🐰", "🐼", "🐱", "🐶", "🦄", "🐧", "🐢", "🐴"],
         .food: ["🍌", "🍕", "🍣", "🍝", "🍰", "🥑", "🍓", "🥗", "🍪", "🍡"],
         .party: ["🥂", "🎲", "🎉", "🎈", "💃", "🕺", "🎤", "🎶", "🔊", "💋"],
         .summer: ["☀️", "🍹", "🌺", "🌴", "🌹", "🍦", "🏄‍♂️", "🛹", "🕶", "🏖"],
         .winter: ["⛄️", "🌨", "☂️", "☕️", "🎿", "🏂", "🏔", "🛷", "🍂", "🍁"]
        ]
    }()
    
    private(set) var contents: [CardContent] = []
    private var emojis: [CardContent]
    
    init(theme: Theme) {
        self.emojis = emojiLookup[theme] ?? []
        contents = generateCards()
    }
    
    func createCardContent(at index: Int) -> CardContent {
        guard index < contents.count else {
            assertionFailure()
            return ""
        }
        return contents[index]
    }
    
    private mutating func generateCards() -> [CardContent] {
        let numberOfPairs = Int.random(in: 6...emojis.count)
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
