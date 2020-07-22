//
//  ContentView.swift
//  Memorize
//
//  Created by Izzy on 22/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiGameViewModel
    
    var body: some View {
        ScrollView {
            VStack() {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .frame(width: 40, height: 50)
                        .onTapGesture {
                            self.viewModel.choose(card: card)
                    }
                }
                .padding()
                .foregroundColor(.orange)
                .font(.body)
            }
        }
    }
}

struct CardView: View {
    
    var card: MemoryGameModel<Emoji>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(lineWidth: 1)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10).fill(Color.orange)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiGameViewModel())
    }
}
