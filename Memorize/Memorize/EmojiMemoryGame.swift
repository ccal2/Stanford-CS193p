//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 03/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    typealias StringMemoryGame = MemoryGame<String>

    // MARK: - Properties

    // MARK: Access to the Model

    var cards: [StringMemoryGame.Card] {
        model.cards
    }

    var score: String {
        "Score: \(model.score)"
    }

    var color: Color {
        theme.color
    }

    var themeName: String {
        theme.name
    }

    // MARK: Model

    @Published private var model: StringMemoryGame

    private var theme: StringMemoryGame.Theme

    // MARK: - Methods

    // MARK: Static

    static func createMemoryGame(with theme: StringMemoryGame.Theme) -> MemoryGame<String> {
        let content = theme.content.shuffled()
        return StringMemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards ?? Int.random(in: 2 ... 5)) { pairIndex in
            content[pairIndex]
        }
    }

    // MARK: Initializers

    init() {
        theme = StringMemoryGame.Theme.allBasics.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

    // MARK: Intents

    func choose(card: StringMemoryGame.Card) {
        model.choose(card: card)
    }

    func startNewGame() {
        theme = StringMemoryGame.Theme.allBasics.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }

}
