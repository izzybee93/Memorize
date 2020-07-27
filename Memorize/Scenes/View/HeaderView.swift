//
//  HeaderView.swift
//  Memorize
//
//  Created by Izzy on 27/07/2020.
//  Copyright © 2020 Isabel Briant. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var onTapButton: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.footnote)
                .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
            Spacer()
            Button(action: {
                self.onTapButton()
            }, label: {
                Text("New Game")
                    .padding(8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .font(.footnote)
                })
                .cornerRadius(10)
                .padding(20)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Theme", onTapButton: {})
    }
}
