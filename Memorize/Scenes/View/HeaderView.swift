//
//  HeaderView.swift
//  Memorize
//
//  Created by Izzy on 27/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let score: Int
    let onTapButton: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .padding(Constants.titleInsets)
            Spacer(minLength: Constants.minSpacing)
            Text("Score: \(score)")
            Spacer(minLength: Constants.minSpacing)
            Button(action: {
                withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                    self.onTapButton()
                }
            }, label: {
                Text("New Game")
                    .padding(8)
                    .background(Color.black)
                    .foregroundColor(.white)
                })
                .font(.footnote)
                .cornerRadius(Constants.buttonCornerRadius)
                .padding(Constants.buttonPadding)
        }
    }
}

private extension HeaderView {
    enum Constants {
        static let titleInsets = EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        static let minSpacing: CGFloat = 8
        static let buttonPadding: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 10
        static let animationDuration = 0.6
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Theme", score: 0, onTapButton: {})
    }
}
