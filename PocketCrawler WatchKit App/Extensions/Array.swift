//
//  Array.swift
//  Array
//
//  Created by Sam Garson on 01/08/2021.
//

import Foundation

extension Array {
    mutating func popRandom<T>(using generator: inout T) -> Element? where T : RandomNumberGenerator {
        guard count > 0 else { return nil }
        let i = Int.random(in: 0..<count, using: &generator)
        return remove(at: i)
    }
}
