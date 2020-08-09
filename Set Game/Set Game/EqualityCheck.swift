//
//  EqualityCheck.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 06/08/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

func allEqual<T: Equatable>(_ elements: [T]) -> Bool {
    for index in 0 ..< elements.count - 1 {
        if elements[index] != elements[index+1] {
            return false
        }
    }

    return true
}

func allDifferent<T: Equatable>(_ elements: [T]) -> Bool {
    for i in 0 ..< elements.count - 1 {
        for j in i+1 ..< elements.count {
            if elements[i] == elements[j] {
                return false
            }
        }
    }

    return true
}

func allEqualOrAllDifferent<T: Equatable>(_ elements: [T]) -> Bool {
    return allEqual(elements) || allDifferent(elements)
}
