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

    // MARK: Model

    @Published private var game: SetGame

    // MARK: - Methods

    // MARK: Initializers

    init() {
        game = SetGame()
    }

    // MARK: Intent

    func deal3MoreCards() {
        game.deal3Cards()
    }

}
