//
//  FocusableTextField.swift
//  RadixApp
//
//  Created by Maximilian Wendel on 2021-03-21.
//

import SwiftUI
#if os(iOS)
import UIKit

typealias ViewRepresentable = UIViewRepresentable
typealias ViewRepresentableContext = UIViewRepresentableContext
typealias TextFieldDelegate = UITextFieldDelegate
typealias _TextField = UITextField
#elseif os(macOS)
import Cocoa

typealias ViewRepresentable = NSViewRepresentable
typealias ViewRepresentableContext = NSViewRepresentableContext
typealias TextFieldDelegate = NSTextFieldDelegate
typealias _TextField = NSTextField

extension NSTextField {
    fileprivate var text: String? {
        get {
            return self.stringValue
        }
        set {
            self.stringValue = newValue ?? ""
        }
    }
}
#endif

// Adapted from https://stackoverflow.com/questions/58311022/autofocus-textfield-programmatically-in-swiftui/64546087

struct FocusableTextField: ViewRepresentable {
    typealias NSViewType = _TextField
    
    class Coordinator: NSObject, TextFieldDelegate {
        @Binding var text: String
        @Binding var nextResponder: Bool?
        @Binding var isResponder: Bool?

        init(text: Binding<String>, nextResponder: Binding<Bool?>, isResponder: Binding<Bool?>) {
            _text = text
            _isResponder = isResponder
            _nextResponder = nextResponder
        }

        func textFieldDidChangeSelection(_ textField: _TextField) {
            text = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: _TextField) {
            DispatchQueue.main.async {
                self.isResponder = true
            }
        }

        func textFieldDidEndEditing(_ textField: _TextField) {
            DispatchQueue.main.async {
                self.isResponder = false
                if self.nextResponder != nil {
                    self.nextResponder = true

                }
            }
        }
    }

    @Binding var text: String
    @Binding var nextResponder: Bool?
    @Binding var isResponder: Bool?

    #if os(iOS)
    var keyboard: UIKeyboardType = .default
    #endif

    func makeUIView(context: ViewRepresentableContext<FocusableTextField>) -> _TextField {
        let textField = _TextField(frame: .zero)
        #if os(iOS)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = keyboard
        #endif
        textField.delegate = context.coordinator
        return textField
    }
    
    #if os(macOS)
    func makeNSView(context: Context) -> _TextField {
        makeUIView(context: context)
    }
    #endif

    func makeCoordinator() -> FocusableTextField.Coordinator {
        return Coordinator(
            text: $text,
            nextResponder: $nextResponder,
            isResponder: $isResponder
        )
    }

    func updateUIView(_ uiView: _TextField, context: ViewRepresentableContext<FocusableTextField>) {
        uiView.text = text
        if isResponder ?? false {
            uiView.becomeFirstResponder()
        }
    }
    
    #if os(macOS)
    func updateNSView(_ nsView: _TextField, context: Context) {
        self.updateUIView(nsView, context: context)
    }
    #endif
}

struct FocusableTextField_Previews: PreviewProvider {
    static var previews: some View {
        FocusableTextField(text: .constant("Hello, World!"), nextResponder: .constant(nil), isResponder: .constant(nil))
    }
}
