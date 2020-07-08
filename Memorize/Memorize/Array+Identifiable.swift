//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 08/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

extension Array where Element: Identifiable {

    func firstIndex(matching: Element) -> Int? {
        for index in self.indices {
            if self[index].id == matching.id {
                return index
            }
        }

        return nil
    }

}
