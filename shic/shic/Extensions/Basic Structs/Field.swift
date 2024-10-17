//
//  Field.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct Field: View {
    
    var text: String
    var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
                .font(.custom("Alegreya-Bold", size: 16))
                .foregroundColor(Color.darkPrimary)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
            
            Text(text)
                .font(.custom("Alegreya-Regular", size: 16))
                .foregroundColor(Color.darkPrimary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.darkPrimary, lineWidth: 1)
                        .opacity(!text.isEmpty ? 1.0 : 0.4)
                        .padding(1)
                )
        }
    }
    
}

