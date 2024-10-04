//
//  EndEditing+.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct EndEditingOnTapGesture: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
    }
    
}

extension View {
    
    func endEditing() -> some View {
        self.modifier(EndEditingOnTapGesture())
    }
    
}
