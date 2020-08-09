//
//  Array+EqualityCheck.swift
//  Set Game
//
//  Created by c.cruz.agra.lopes on 06/08/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

extension Array where Element: Equatable {

    func isAllEqual() -> Bool {
        for index in 0 ..< count - 1 {
            if self[index] != self[index+1] {
                return false
            }
        }

        return true
    }

    func isAllDifferent() -> Bool {
        for i in 0 ..< count - 1 {
            for j in i+1 ..< count {
                if self[i] == self[j] {
                    return false
                }
            }
        }

        return true
    }

    func isAllEqualOrAllDifferent() -> Bool {
        return isAllEqual() || isAllDifferent()
    }

}
