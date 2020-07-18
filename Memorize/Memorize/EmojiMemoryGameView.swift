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
                    CardView(card: card, gradientColors: self.viewModel.gradientColors)
                        .aspectRatio(3/3.5, contentMode: .fit)
                        .padding(5)
                        .onTapGesture {
                            self.viewModel.choose(card: card)
                        }
                }
            }
                .foregroundColor(self.viewModel.gradientColors.first)
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

    let card: MemoryGame<String>.Card
    let gradientColors: [Color]

    // MARK: Drawing Constants

    private let fontSize: (CGSize) -> CGFloat = { size in
        min(size.width, size.height) * 0.6
    }

    // MARK: Body

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(20))
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(size)))
            }
                .cardify(gradientColors: gradientColors, isFaceUp: card.isFaceUp)
        }
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
