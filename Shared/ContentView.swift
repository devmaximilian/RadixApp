//
//  ContentView.swift
//  Shared
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import SwiftUI

struct ContentView: View {
    @State var lhsRadix: Radix = .decimal
    @State var rhsRadix: Radix = .binary
    @State var value: Int = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                RadixView(
                    radix: $lhsRadix,
                    value: $value
                )
            }
            Rectangle()
                .frame(width: 1)
                .padding()
                .foregroundColor(Color.secondary.opacity(0.15))
            VStack(alignment: .leading) {
                RadixView(
                    radix: $rhsRadix,
                    value: $value
                )
            }
        }
        .padding(.horizontal)
        .frame(height: 100)
        .frame(minWidth: 250)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(lhsRadix: .decimal, rhsRadix: .binary, value: 100)
    }
}
#endif
