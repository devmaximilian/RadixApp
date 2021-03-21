//
//  ContentView.swift
//  Shared
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import SwiftUI

struct ContentView: View {
    #if os(macOS)
    typealias LayoutStack = HStack
    #else
    typealias LayoutStack = VStack
    #endif
    
    #if os(macOS)
    private let height: CGFloat = 110
    #else
    private let height: CGFloat = 500
    #endif
    
    @State var lhsRadix: Radix = .decimal
    @State var rhsRadix: Radix = .binary
    @State var value: Int = 0
    
    var body: some View {
        LayoutStack(alignment: .center) {
            VStack(alignment: .leading) {
                RadixView(
                    radix: $lhsRadix,
                    value: $value
                )
            }
            #if os(macOS)
            Rectangle()
                .frame(width: 1)
                .padding()
                .foregroundColor(Color.secondary.opacity(0.15))
            #else
            Rectangle()
                .frame(height: 1)
                .padding()
                .foregroundColor(Color.secondary.opacity(0.15))
            #endif
            VStack(alignment: .leading) {
                RadixView(
                    radix: $rhsRadix,
                    value: $value
                )
            }
        }
        .frame(height: height, alignment: .center)
        .padding(.horizontal)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(lhsRadix: .decimal, rhsRadix: .binary, value: 100)
    }
}
#endif
