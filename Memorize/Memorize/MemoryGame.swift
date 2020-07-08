//
//  MemoryGame.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 03/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {

    // MARK: - Properties

    var cards: [Card]

    // MARK: - Methods

    // MARK: Initializer

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }

    // MARK: Card manipulation

    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        guard let chosenIndex = index(of: card) else { return }
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }

    func index(of card: Card) -> Int? {
        for index in 0 ..< cards.count {
            if cards[index].id == card.id {
                return index
            }
        }

        return nil
    }

}

// MARK: - Card

extension MemoryGame {

    struct Card: Identifiable {

        // MARK: Properties

        var isFaceUp: Bool = false
        var isMathced: Bool = false
        var content: CardContent

        // MARK: Identifiable

        var id: Int
    }
    
}
