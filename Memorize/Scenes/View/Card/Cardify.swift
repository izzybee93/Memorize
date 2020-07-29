//
//  Cardify.swift
//  Memorize
//
//  Created by Izzy on 27/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier { // AnimatableModifier = ViewModifier & Animatable
    private var color: Color
    private var rotation: Double

    private var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, color: Color) {
        self.rotation = isFaceUp ? 0 : 180
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .circular)
                    .stroke(lineWidth: Constants.lineWidth)
                content
            }.opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(RadialGradient(gradient: Gradient(colors: [.purple, color]), center: .center, startRadius: 2, endRadius: 70))
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (x: 0, y: 180, z: 0))
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
