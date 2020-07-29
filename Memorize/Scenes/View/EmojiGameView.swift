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
    
    private var themeColor: Color {
        ColorProvider.color(for: self.viewModel.theme)
    }
    
    var body: some View {
        VStack {
            HeaderView(title: viewModel.theme.rawValue.capitalized, score: viewModel.score) {
                self.viewModel.startNewGame()
            }
            Spacer()
            Grid(viewModel.cards) { card in
                CardView(card: card, color: self.themeColor)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.4)) {
                            self.viewModel.choose(card: card)
                        }
                }.padding(4)
            }
            .padding(10)
            .foregroundColor(themeColor)
        }
    }
}

struct ColorProvider {
    private static let colorLookup: [Theme: Color] = [.halloween: .orange,
                                                      .animals: .green,
                                                      .food: .red,
                                                      .party: .pink,
                                                      .summer: .yellow,
                                                      .winter: .blue]
    
    static func color(for theme: Theme) -> Color {
        colorLookup[theme] ?? .black
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(viewModel: EmojiGameViewModel(theme: Theme.random))
    }
}
