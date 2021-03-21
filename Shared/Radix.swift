//
//  Radix.swift
//  RadixApp
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import Foundation

enum Radix: Int {
    case binary = 2
    case decimal = 10
    case hexadecimal = 16
}

// Display name

extension Radix {
    var displayName: String {
        switch self {
        case .binary: return "Binary"
        case .decimal: return "Decimal"
        case .hexadecimal: return "Hexadecimal"
        }
    }
}

// Display value

extension Radix {
    func displayValue(_ value: Int) -> String {
        return String(value, radix: rawValue)
        // TODO: Spacing for readability
        // stride(from: 0, to: string.count, by: 4)
    }
}
