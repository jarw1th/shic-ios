//
//  MainButton.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct MainButton: View {
    
    var disabling: Bool = false
    @Binding var isAvailable: Bool
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(Font.custom("Alegreya-Bold", size: 20))
                .lineLimit(1)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.darkPrimary)
                        .opacity(isAvailable ? 1.0 : 0.4)
                }
        }
        .disabled(disabling ? !isAvailable : false)
    }
    
}

