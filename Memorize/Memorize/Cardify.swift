//
//  Cardify.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 17/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {

    // MARK: - Properties

    let gradientColors: [Color]
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
    private let edgeLineWidth: CGFloat = 3.0

    // MARK: - Methods

    // MARK: Initializer

    init(gradientColors: [Color], isFaceUp: Bool) {
        self.gradientColors = gradientColors
        self.rotation = isFaceUp ? 0 : 180
    }

    // MARK: Body (AnimatableModifier)

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: edgeLineWidth)
            content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottomTrailing))
                .opacity(isFaceUp ? 0 : 1)
            
        }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
}

// MARK: - View extension

extension View {

    func cardify(gradientColors: [Color], isFaceUp: Bool) -> some View {
        self.modifier(Cardify(gradientColors: gradientColors, isFaceUp: isFaceUp))
    }

}
