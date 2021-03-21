//
//  RadixApp.swift
//  Shared
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import SwiftUI

@main
struct RadixApp: App {
    @ObservedObject var radixModel: RadixModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(radixModel)
        }
    }
}
