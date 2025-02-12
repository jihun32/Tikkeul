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
            
            // NSRange를 Swift의 Range로 변환
            guard let textRange = Range(range, in: currentText) else {
                return false
            }
            
            // 변경 후의 전체 텍스트
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            
            // 콤마를 제거한 순수 숫자 문자열
            let onlyNumberString = updatedText.replacingOccurrences(of: ",", with: "")
            
            // 전체 삭제된 경우
            if onlyNumberString.isEmpty {
                textField.text = ""
                parent.text = ""
                return false
            }
            
            // 숫자만 카운트해서 maxCount를 초과하면 입력 무시
            if onlyNumberString.count > parent.maxCount {
                return false
            }
            
            // 숫자로 변환 가능한 경우 포맷팅
            if let number = Double(onlyNumberString) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                if let formattedText = formatter.string(from: NSNumber(value: number)) {
                    
                    textField.text = formattedText
                    parent.text = formattedText
                }
            }
            return false
        }
    }
}
