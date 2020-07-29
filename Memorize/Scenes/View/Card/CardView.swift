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
            self.body(for: geometry.size)
        }
    }

    @State private var animatedBonusRemaining: Double = 0
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if self.card.isFaceUp || !self.card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Constants.pieStartAngle, endAngle: Angle(degrees: -animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Constants.pieStartAngle, endAngle: Angle(degrees: -card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(Constants.piePadding)
                .opacity(Constants.pieOpacity)

                Text(card.content)
                    .font(.system(size: Constants.fontSize(for: size)))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: Constants.animationDuration).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp, color: color)
            .transition(.scale)
        }
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
}

private extension CardView {
    enum Constants {
        static let fontScaleFactor: CGFloat = 0.7
        static let pieStartAngle = Angle(degrees: -90)
        static let piePadding: CGFloat = 3
        static let pieOpacity = 0.4
        static let animationDuration = 0.6

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
