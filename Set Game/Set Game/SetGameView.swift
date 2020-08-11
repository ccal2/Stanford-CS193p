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
    private let transitionDuration: Double = 0.5
    private let deckPadding: CGFloat = 20.0
    private let deckHeight: CGFloat = 130

    private var offset: CGSize {
        CGSize(width: CGFloat.random(in: -1000...1000), height: CGFloat.random(in: -1000...1000))
    }

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
                DeckView(viewModel: viewModel)
                    .aspectRatio(cardAspectRatio, contentMode: .fit)
                    .frame(width: nil, height: deckHeight)
                    .padding(.leading, deckPadding)
                    .onTapGesture {
                        self.viewModel.dealMoreCards()
                    }
                Spacer()
            }
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                    .padding(self.cardPadding)
                    .transition(.offset(self.offset))
                    .animation(.easeInOut(duration: self.transitionDuration))
                    .onTapGesture {
                        self.viewModel.select(card)
                    }
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
