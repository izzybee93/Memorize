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
    
    let contents = ["👻", "🎃", "🕷"]
    
    func createCardContent(at index: Int) -> CardContent {
        guard index < contents.count else {
            assertionFailure()
            return ""
        }
        return contents[index]
    }
}
