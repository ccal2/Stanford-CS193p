//
//  Array+Only.swift
//  Memorize
//
//  Created by c.cruz.agra.lopes on 08/07/20.
//  Copyright © 2020 Carolina Lopes. All rights reserved.
//

extension Array {

    var only: Element? {
        (count == 1) ? first : nil
    }

}
