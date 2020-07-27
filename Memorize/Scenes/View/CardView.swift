//
//  CardView.swift
//  Memorize
//
//  Created by Izzy on 27/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGameModel<Emoji>.Card
    var color: Color
    
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
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill(RadialGradient(gradient: Gradient.init(colors: [.purple, color]), center: .center, startRadius: 2, endRadius: 70))
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(card: MemoryGameModel<Emoji>.Card(id: 0, content: "🍄", isFaceUp: false), color: .purple)
            CardView(card: MemoryGameModel<Emoji>.Card(id: 0, content: "🍄", isFaceUp: true), color: .purple)
        }.frame(width: 100, height: 200, alignment: .center)
    }
}
