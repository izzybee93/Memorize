//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Izzy on 22/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var viewModel: EmojiGameViewModel
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card)
                .aspectRatio(2/3, contentMode: .fit)
                .onTapGesture {
                    self.viewModel.choose(card: card)
            }.padding(4)
        }
        .padding(10)
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGameModel<Emoji>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .circular)
                    .stroke(lineWidth: Constants.lineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius).fill(Color.orange)
                }
            }
        }
        .font(.system(size: Constants.fontSize(for: size)))
    }
}

private extension CardView {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1
        private static let fontScaleFactor: CGFloat = 0.75
        
        static func fontSize(for availableSize: CGSize) -> CGFloat {
            min(availableSize.width, availableSize.height) * self.fontScaleFactor
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(viewModel: EmojiGameViewModel())
    }
}
