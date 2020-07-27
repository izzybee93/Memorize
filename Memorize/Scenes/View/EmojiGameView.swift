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
        VStack {
            HeaderView(title: viewModel.theme.rawValue.capitalized) {
                self.viewModel.startNewGame()
            }
            Spacer()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(viewModel: EmojiGameViewModel(theme: Theme.random))
    }
}
