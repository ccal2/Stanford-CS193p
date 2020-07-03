//
//  ContentView.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 02/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var viewModel: EmojiMemoryGame

    // MARK: Body

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
            .padding()  // this is applied only for the stack
            .foregroundColor(.orange)  // all views inside it will have a .orange foregroundColor
            .font(.largeTitle)  // this is applied to all texts inside the stack
    }
}

// MARK: - CardView

struct CardView: View {

    var card: MemoryGame<String>.Card

    // MARK: Body

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill()
            }
        }
    }
}



// MARK: - Preview

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }

}
