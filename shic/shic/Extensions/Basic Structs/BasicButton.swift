//
//  Button.swift
//  shic
//
//  Created by Руслан Парастаев on 07.10.2024.
//

import SwiftUI

struct BasicButton: View {
    
    var header: String? = nil
    var title: String
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header {
                Text(header)
                    .font(.custom("Alegreya-Bold", size: 16))
                    .foregroundColor(Color.darkPrimary)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
            }
            
            Button {
                action()
            } label: {
                Text(title)
                    .font(.custom("Alegreya-Bold", size: 16))
                    .foregroundColor(Color.darkPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.darkPrimary, lineWidth: 1.5)
                            .padding(1)
                    )
            }
        }
    }
    
}
