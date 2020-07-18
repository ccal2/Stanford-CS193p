//
//  CardView.swift
//  Memorize
//
//  Created by Carolina Cruz Agra Lopes on 18/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct CardView: View {

    // MARK: - Properties

    let card: MemoryGame<String>.Card
    let gradientColors: [Color]

    // MARK: Drawing Constants

    private let piePadding: CGFloat = 5
    private let pieOpacity: Double = 0.4
    private let fontSize: (CGSize) -> CGFloat = { size in
        min(size.width, size.height) * 0.6
    }

    // MARK: Animation

    @State private var animatedBonusRemaining: Double = 0

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-(animatedBonusRemaining * 360) - 90))
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-(card.bonusRemaining * 360) - 90))
                    }
                }
                    .padding(piePadding)
                    .opacity(pieOpacity)
                    .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(gradientColors: gradientColors, isFaceUp: card.isFaceUp)
            .transition(.scale)
        }
    }

    // MARK: - Methods

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
}
