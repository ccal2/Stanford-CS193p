//
//  CardView.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct CardView: View {

    // MARK: - Properties

    let card: SetGame.Card

    // MARK: Drawing Constants

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 4.0
    private let shapeAspectRatio: CGFloat = 2.0
    private let frameMultiplier: CGFloat = 0.75
    private let backColor: Color = .gray

    private var borderColor: Color {
        switch card.state {
        case .unselected:
            return backColor
        case .suggested:
            return .orange
        case .selected:
            return .blue
        case .matched:
            return .green
        case .unmatched:
            return .red
        }
    }

    private var contentColor: Color {
        switch card.color {
        case .red:
            return .red
        case .green:
            return .green
        case .purple:
            return .purple
        }
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }

    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(borderColor)
                VStack {
                    ForEach (0 ..< card.quantity.rawValue) { _ in
                        self.cardShape()
                    }
                }
                    .frame(width: size.width * frameMultiplier, height: size.height * frameMultiplier, alignment: .center)
                    .foregroundColor(contentColor)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backColor)
            }
        }
    }

    // MARK: - Methods

    // MARK: Shape drawing

    @ViewBuilder
    private func cardShape() -> some View {
        Group {
            if card.shape == .diamond {
                diamond()
            } else if card.shape == .rectangle {
                rectangle()
            } else {    // card.shape == .oval
                oval()
            }
        }
            .aspectRatio(shapeAspectRatio, contentMode: .fit)
    }

    @ViewBuilder
    private func diamond() -> some View {
        if card.shading == .open {
            Diamond()
                .stroke(lineWidth: edgeLineWidth)
        } else if card.shading == .striped {
            ZStack {
                Diamond()
                    .stroke(lineWidth: edgeLineWidth)
                Diamond()
                    .fill(ImagePaint(image: Image("striped")))
            }
        } else {    // card.sading == .solid
            Diamond()
        }
    }

    @ViewBuilder
    private func rectangle() -> some View {
        if card.shading == .open {
            Rectangle()
                .stroke(lineWidth: edgeLineWidth)
        } else if card.shading == .striped {
            ZStack {
                Rectangle()
                    .stroke(lineWidth: edgeLineWidth)
                Rectangle()
                    .fill(ImagePaint(image: Image("striped")))
            }
        } else {    // card.sading == .solid
            Rectangle()
        }
    }

    @ViewBuilder
    private func oval() -> some View {
        if card.shading == .open {
            Capsule()
                .stroke(lineWidth: self.edgeLineWidth)
        } else if card.shading == .striped {
            ZStack {
                Capsule()
                    .stroke(lineWidth: self.edgeLineWidth)
                Capsule()
                    .fill(ImagePaint(image: Image("striped")))
            }
        } else {    // card.sading == .solid
            Capsule()
        }
    }

}



// MARK: - Preview

struct CardView_Previews: PreviewProvider {

    static let cards = [
        SetGame.Card(shape: .diamond, quantity: .one, shading: .open, color: .red),
        SetGame.Card(shape: .rectangle, quantity: .two, shading: .striped, color: .green),
        SetGame.Card(shape: .oval, quantity: .three, shading: .solid, color: .purple)
    ]

    static var previews: some View {
        VStack {
            ForEach(cards) { card in
                CardView(card: card)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }

}
