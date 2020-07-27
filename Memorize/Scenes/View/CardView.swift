//
//  CardView.swift
//  Memorize
//
//  Created by Izzy on 27/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGameModel<Emoji>.Card
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            if self.card.isFaceUp || !self.card.isMatched {
                self.body(for: geometry.size)
            }
        }
    }
    
    private func body(for size: CGSize) -> some View {
        return ZStack {
            Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 20), clockwise: true)
                .padding(3)
                .opacity(0.2)
            Text(card.content)
                .font(.system(size: Constants.fontSize(for: size)))
        }
        .cardify(isFaceUp: card.isFaceUp, color: color)
    }
}

private extension CardView {
    enum Constants {
        private static let fontScaleFactor: CGFloat = 0.7

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
