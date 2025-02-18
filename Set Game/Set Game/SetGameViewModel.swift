//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {

    // MARK: - Properties

    // MARK: Access to the Model

    var cards: [SetGame.Card] {
        game.dealtCards
    }

    var isDeckEmpty: Bool {
        game.deck.isEmpty
    }

    var numberOfCardsToDeal: Int {
        game.numberOfCardsToDeal
    }

    // MARK: Model

    @Published private var game: SetGame

    // MARK: - Methods

    // MARK: Initializers

    init() {
        game = SetGame()
    }

    // MARK: Intents

    func select(_ card: SetGame.Card) {
        game.select(card)
    }

    func dealMoreCards() {
        game.dealMoreCards()
    }

    func startNewGame() {
        game.startNewGame()
    }

}
