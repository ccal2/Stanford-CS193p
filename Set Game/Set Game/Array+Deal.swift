//
//  Array+Deal.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 27/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

extension Array where Element == SetGame.Card {

    mutating func deal(numberOfCards: Int) -> [Element] {
        var cards: [Element] = []

        for _ in 0 ..< numberOfCards {
            if self.isEmpty {
                break
            }
            cards.append(self.removeFirst())
        }

        return cards
    }

}
