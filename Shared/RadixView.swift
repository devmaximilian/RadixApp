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
    
    @State var isEditing: Bool = false
    @State var text: String = ""
    
    var body: some View {
        ZStack {
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
            .fixedSize()
            .padding()
            .onTapGesture(count: 2, perform: beginEditing)
            .opacity(isEditing ? 0 : 1)
            if isEditing {
                VStack {
                    Picker("Type", selection: $radix) {
                        ForEach(Radix.allCases, id: \.self) { radix in
                            Text(radix.displayName)
                                .tag(radix.id)
                        }
                    }
                    .onChange(of: radix) { _ in
                        updateValue(using: text)
                    }
                    FocusableTextField(
                        text: $text,
                        nextResponder: .constant(false),
                        isFirstResponder: .constant(true)
                    )
                    .foregroundColor(.primary)
                    .onChange(of: text, perform: updateValue)
                    Button("Done", action: finishEditing)
                }
            }
        }
    }
    
    func beginEditing() {
        self.text = value == 0 ? "" : radix.displayValue(value)
        self.isEditing = true
    }
    
    func updateValue(using string: String) {
        if let newValue = radix.value(from: string) {
            self.value = newValue
        }
    }
    
    func finishEditing() {
        self.isEditing = false
        self.text = ""
    }
}

#if DEBUG
struct RadixView_Previews: PreviewProvider {
    static var previews: some View {
        RadixView(radix: .constant(.binary), value: .constant(16))
    }
}
#endif
