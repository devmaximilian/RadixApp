//
//  Radix.swift
//  RadixApp
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import Foundation

enum Radix: Int, CaseIterable {
    case binary = 2
    case decimal = 10
    case hexadecimal = 16
}

// Identifiable conformance

extension Radix: Identifiable {
    var id: Int {
        return self.rawValue
    }
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
        return String(value, radix: self.rawValue)
        // TODO: Spacing for readability
        // stride(from: 0, to: string.count, by: 4)
    }
}

// Value parsing

extension Radix {
    func value(from text: String) -> Int? {
        return Int(text, radix: self.rawValue)
    }
}
