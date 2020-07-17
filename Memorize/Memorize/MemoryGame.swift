//
//  MemoryGame.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 03/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent: Hashable> {

    // MARK: - Properties

    private(set) var cards: [Card]
    private(set) var score: Int
    private(set) var dateOfLastCardChoosing: Date!

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp }.only
        }

        set {
            for index in cards.indices {
                cards[index].hasBeenSeen = cards[index].hasBeenSeen ? true : cards[index].isFaceUp
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
        score = 0
        dateOfLastCardChoosing = nil
    }

    // MARK: Card manipulation

    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        guard let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else { return }

        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            var scoreMultiplier: Int = 0
            let secondsSinceLastChoosing = Int(Date().timeIntervalSince(dateOfLastCardChoosing))

            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
                scoreMultiplier = 2
            } else {
                if cards[chosenIndex].hasBeenSeen {
                    scoreMultiplier = -1
                }
                if cards[potentialMatchIndex].hasBeenSeen {
                    scoreMultiplier = -1
                }
            }

            score += scoreMultiplier * max(cards.count - secondsSinceLastChoosing, 1)
            cards[chosenIndex].isFaceUp = true
        } else {
            dateOfLastCardChoosing = Date()
            indexOfTheOneAndOnlyFaceUpCard = chosenIndex
        }
    }

}

// MARK: - Card

extension MemoryGame {

    struct Card: Identifiable {

        // MARK: Properties

        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false

        // MARK: Identifiable

        var id: Int
    }
    
}
