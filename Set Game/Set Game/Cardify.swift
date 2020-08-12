//
//  Cardify.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 12/08/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {

    // MARK: - Properties

    var rotation: Double

    var isFaceUp: Bool {
        rotation < 90
    }

    // MARK: AnimatableModifier

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    // MARK: Drawing Constants

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 4.0
    private let backColor: Color = .gray
    private let borderColor: Color

    // MARK: - Methods

    // MARK: Initializer

    init(isFaceUp: Bool, borderColor: Color) {
        self.rotation = isFaceUp ? 0 : 180
        self.borderColor = borderColor
    }

    // MARK: - Body

    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(borderColor)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backColor)
            }
        }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0), perspective: 0.5)
    }

}


// MARK: - View extension

extension View {

    func cardify(isFaceUp: Bool, borderColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, borderColor: borderColor))
    }

}
