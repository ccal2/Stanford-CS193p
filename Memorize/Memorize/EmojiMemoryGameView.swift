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
        VStack {
            Group {
                Text(viewModel.themeName)
                    .font(.largeTitle)
                Spacer()
                Text(viewModel.score)
                    .font(.title)
                Grid(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(3/3.5, contentMode: .fit)
                        .padding(5)
                        .onTapGesture {
                            self.viewModel.choose(card: card)
                    }
                }
            }
                .foregroundColor(self.viewModel.color)
            Divider()
            Button (action: {
                self.viewModel.startNewGame()
            }, label: {
                Text("New Game")
                    .font(.title)
            })
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
            } else if !card.isMatched {
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
