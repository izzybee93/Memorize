//
//  Cardify.swift
//  Memorize
//
//  Created by Izzy on 27/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .circular)
                    .stroke(lineWidth: Constants.lineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(RadialGradient(gradient: Gradient.init(colors: [.purple, color]), center: .center, startRadius: 2, endRadius: 70))
            }
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}

private extension Cardify {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 1
    }
}
