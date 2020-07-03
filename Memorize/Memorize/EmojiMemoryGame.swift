//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 03/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import Foundation

class EmojiMemoryGame {

    // MARK: - Properties

    // MARK: Access to the Model

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    // MARK: Model

    private var model: MemoryGame<String>

    // MARK: - Methods

    // MARK: Static

    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: [String] = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }

    // MARK: Initializer

    init() {
        model = EmojiMemoryGame.createMemoryGame()
    }

    // MARK: Intent(s)

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }

}
