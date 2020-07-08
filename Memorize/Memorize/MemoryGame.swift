//
//  MemoryGame.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 03/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {

    // MARK: - Properties

    var cards: [Card]
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp }.only
        }

        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

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
        guard let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else { return }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            cards[chosenIndex].isFaceUp = true
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }

}

// MARK: - Card

extension MemoryGame {

    struct Card: Identifiable {

        // MARK: Properties

        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent

        // MARK: Identifiable

        var id: Int
    }
    
}
