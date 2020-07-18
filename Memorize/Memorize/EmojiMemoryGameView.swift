//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 02/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: EmojiMemoryGame

    // MARK: Drawing Constants

    private let cardAspectRatio: CGFloat = 3/3.5
    private let cardPadding: CGFloat = 5

    // MARK: - Body

    var body: some View {
        VStack {
            Group {
                Text(viewModel.themeName)
                    .font(.largeTitle)
                Spacer()
                Text(viewModel.score)
                    .font(.title)
                Grid(viewModel.cards) { card in
                    CardView(card: card, gradientColors: self.viewModel.gradientColors)
                        .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                        .padding(self.cardPadding)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.75)) {
                                self.viewModel.choose(card: card)
                            }
                        }
                }
            }
                .foregroundColor(viewModel.gradientColors.first)
            Divider()
            Button (action: {
                withAnimation(.easeInOut) {
                    self.viewModel.startNewGame()
                }
            }, label: {
                Text("New Game")
                    .font(.title)
            })
        }
            .padding()
    }

}



// MARK: - Preview

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }

}
