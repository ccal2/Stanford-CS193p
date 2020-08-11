//
//  DeckView.swift
//  Set Game
//
//  Created by Carolina Cruz Agra Lopes on 09/08/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct DeckView: View {

    // MARK: - Properties
    
    @ObservedObject var viewModel: SetGameViewModel

    // MARK: Drawing Constants

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 4.0
    private let outlineColor: Color = .gray
    private let emptyTextSize: CGFloat = 15.0
    private let emptyOpacity: Double = 0.5

    // MARK: - Body

    var body: some View {
        Group {
            if viewModel.deck.isEmpty {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(lineWidth: edgeLineWidth)
                        .foregroundColor(outlineColor)
                    Text("Empty")
                        .font(.system(size: emptyTextSize))
                }
                    .opacity(emptyOpacity)
            } else {
                CardView(card: viewModel.deck.first!)
            }
        }
    }

}
