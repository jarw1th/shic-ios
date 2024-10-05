//
//  CodeField.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct CodeField: View {
    
    @Binding var text: String
    @State private var code: [String] 
    @FocusState private var focusField: Int?
    private let numberOfDigits: Int
    private let placeholder: String = "-"
    
    init(text: Binding<String>, numberOfDigits: Int) {
        self._text = text
        self.numberOfDigits = numberOfDigits
        self.code = Array(repeating: "", count: numberOfDigits)
    }
    
    var body: some View {
        HStack(spacing: 8) {
            if code.count == numberOfDigits {
                ForEach(0..<numberOfDigits, id: \.self) { index in
                    makeField($code[index], index: index)
                }
            }
        }
        .onChange(of: text) { newValue in
            text = format(newValue)
            if text.count == numberOfDigits {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .onAppear {
            focusField = 0
        }
        .onChange(of: code) { newValue in
            text = code.joined()
        }
    }
    
    private func makeField(_ digit: Binding<String>, index: Int) -> some View {
        ZStack(alignment: .center) {
            if digit.wrappedValue.isEmpty {
                Text(placeholder)
                    .font(.custom("Alegreya-Regular", size: 16))
                    .foregroundColor(Color.darkPrimary.opacity(0.4))
                    .multilineTextAlignment(.center)
            }
            TextField("", text: digit)
                .keyboardType(.numberPad)
                .font(.custom("Alegreya-Regular", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.darkPrimary)
                .focused($focusField, equals: index)
                .onChange(of: code[index]) { newValue in
                    if newValue.count > 1 {
                        code[index] = String(newValue.prefix(1))
                    }
                    
                    if newValue.count == 1 && index < 3 {
                        focusField = index + 1
                    }
                    
                    if newValue.isEmpty && index > 0 {
                        focusField = index - 1
                    }
                }
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.darkPrimary, lineWidth: 1)
                .opacity(!digit.wrappedValue.isEmpty ? 1.0 : 0.4)
        )
    }
    
    private func format(_ code: String) -> String {
        return code.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
}

