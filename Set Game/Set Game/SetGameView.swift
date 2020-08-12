//
//  SetGameView.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

struct SetGameView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: SetGameViewModel

    // MARK: Drawing Constants

    private let cardAspectRatio: CGFloat = 2/3
    private let cardPadding: CGFloat = 5.0
    private let deckPadding: CGFloat = 20.0
    private let deckHeight: CGFloat = 130
    private let animationDuration: Double = 1

    // MARK: State

    @State private var deckPosition: (x: CGFloat, y: CGFloat) = (.zero, .zero)
    @State private var offsets: [String: CGSize] = [:]
    @State private var scales: [String: CGFloat] = [:]

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.startNewGame()
                }, label: {
                    Text("New Game")
                })
                    .padding(.trailing)
            }
            HStack {
                Spacer()
                Text("Set")
                    .font(.system(.largeTitle))
                    .bold()
                Spacer()
            }
            HStack {
                GeometryReader { geometry in
                    DeckView(deck: self.viewModel.deck)
                        .onTapGesture {
                            self.viewModel.dealMoreCards()
                        }
                        .onAppear() {
                            let frame = geometry.frame(in: .global)
                            self.deckPosition = (x: frame.minX, y: frame.minY)
                        }
                }
                    .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                    .padding(.leading, self.deckPadding)
                Spacer()
            }
                .frame(width: nil, height: deckHeight)
            Grid(viewModel.cards) { card in
                GeometryReader { geometry in
                    CardView(card: card)
                        .offset(self.offsets[card.id] ?? .zero)
                        .scaleEffect(self.scales[card.id] ?? 1.0, anchor: .topLeading)
                        .onAppear() {
                            let frame = geometry.frame(in: .global)
                            let height = frame.maxY - frame.minY
                            let scale = self.deckHeight/height
                            self.scales[card.id] = scale
                            self.offsets[card.id] = CGSize(width: -abs(frame.minX - self.deckPosition.x)/scale, height: -abs(frame.minY - self.deckPosition.y)/scale)
                            withAnimation(.easeInOut) {
                                self.viewModel.faceUp(card: card)
                                self.offsets[card.id] = .zero
                                self.scales[card.id] = 1.0
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.viewModel.select(card)
                            }
                        }
                }
                    .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                    .padding(self.cardPadding)
                    .animation(.easeInOut(duration: self.animationDuration))
            }
        }
            .onAppear() {
                self.viewModel.startNewGame()
            }
    }

}



// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
