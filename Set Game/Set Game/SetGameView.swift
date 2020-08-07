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

    // MARK: - Body

    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: {
                self.viewModel.startNewGame()
            }, label: {
                Text("New Game")
            })
            VStack {
                Text("Set")
                    .font(.system(.largeTitle))
                    .bold()
                Grid(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(self.cardAspectRatio, contentMode: .fit)
                        .padding(self.cardPadding)
                        .onTapGesture {
                            self.viewModel.select(card)
                    }
                }
                Button(action: {
                    self.viewModel.deal3MoreCards()
                }, label: {
                    Text("Deal 3 More Cards")
                })
                    .disabled(viewModel.isDeckEmpty)
                    .padding()
            }
        }
    }

}



// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
