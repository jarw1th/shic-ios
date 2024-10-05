//
//  TopHeaderText.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct TopHeaderText: View {
    
    var header: String?
    var text: String?
    
    init(header: String? = nil, text: String? = nil) {
        self.header = header
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if let header {
                Text(header)
                    .font(Font.custom("Alegreya-Bold", size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.darkPrimary)
            }
            Text(text ?? " ")
                .font(Font.custom("Alegreya-Regular", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.darkPrimary)
        }
    }
    
}
