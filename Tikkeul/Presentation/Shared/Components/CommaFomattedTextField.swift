//
//  CommaFomattedTextField.swift
//  Tikkeul
//
//  Created by 정지훈 on 2/12/25.
//

import SwiftUI
import UIKit

struct CommaFomattedUITextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let maxCount: Int
    let font: UIFont
    let textAlignment: NSTextAlignment
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = .numberPad
        textField.font = font
        textField.textAlignment = textAlignment
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if uiView.text != formatNumber(text) {
            uiView.text = formatNumber(text)
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CommaFomattedUITextField
        
        init(_ parent: CommaFomattedUITextField) {
            self.parent = parent
        }
        
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            guard let textRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            let onlyNumberString = updatedText.replacingOccurrences(of: ",", with: "")
            
            if onlyNumberString.isEmpty {
                textField.text = ""
                parent.text = ""
                return false
            }
            
            if onlyNumberString.count > parent.maxCount {
                return false
            }
            
            if let number = Double(onlyNumberString) {
                let formattedText = formatNumber("\(Int(number))")
                textField.text = formattedText
                parent.text = formattedText
            }
            return false
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = parent.text.replacingOccurrences(of: ",", with: "")
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            textField.text = formatNumber(textField.text ?? "")
        }
        
        private func formatNumber(_ value: String) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let number = Int(value), let formattedText = formatter.string(from: NSNumber(value: number)) {
                return formattedText
            }
            return value
        }
    }
    
    private func formatNumber(_ value: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let number = Int(value), let formattedText = formatter.string(from: NSNumber(value: number)) {
            return formattedText
        }
        return value
    }
}
