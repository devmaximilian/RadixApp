//
//  RadixView.swift
//  RadixApp
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import SwiftUI

struct RadixView: View {
    @Binding var radix: Radix
    @Binding var value: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(radix.displayName)
                .font(.body)
                .foregroundColor(.secondary)
            HStack(alignment: .bottom, spacing: 0) {
                Text(radix.displayValue(value))
                    .font(.system(.title, design: .monospaced))
                Text(radix.rawValue.description)
                    .font(.system(.subheadline, design: .monospaced))
                    .bold()
                    .offset(x: 0, y: 2)
            }
        }
        .padding()
    }
}

#if DEBUG
struct RadixView_Previews: PreviewProvider {
    static var previews: some View {
        RadixView(radix: .constant(.binary), value: .constant(16))
    }
}
#endif
