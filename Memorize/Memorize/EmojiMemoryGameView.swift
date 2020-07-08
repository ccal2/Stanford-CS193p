//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 02/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    @ObservedObject var viewModel: EmojiMemoryGame

    // MARK: Body

    var body: some View {
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundColor(.orange)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                    }
            }
        }
            .padding()
    }

}

// MARK: - CardView

struct CardView: View {

    var card: MemoryGame<String>.Card

    // MARK: Drawing Constants

    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontSize: (CGSize) -> CGFloat = { size in
        min(size.width, size.height) * 0.75
    }

    // MARK: Body

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                Text(card.content)
                    .font(Font.system(size: fontSize(size)))
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
        }
    }

}



// MARK: - Preview

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }

}
