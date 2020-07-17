//
//  Cardify.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 17/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {

    // MARK: - Properties

    let gradientColors: [Color]
    var isFaceUp: Bool

    // MARK: Drawing Constants

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0

    // MARK: - Methods

    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottomTrailing))
            }
        }
    }
}

// MARK: - View extension

extension View {

    func cardify(gradientColors: [Color], isFaceUp: Bool) -> some View {
        self.modifier(Cardify(gradientColors: gradientColors, isFaceUp: isFaceUp))
    }

}
