//
//  AcceptField.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct AcceptField<Content: View>: View {
    
    @Binding var isAccepted: Bool
    var label: () -> Content
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                isAccepted.toggle()
            } label: {
                Image(isAccepted ? "RectangleCheckOn" : "RectangleCheckOff")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(Color.darkPrimary)
                    .opacity(isAccepted ? 1.0 : 0.4)
            }
            label()
        }
    }
    
}

