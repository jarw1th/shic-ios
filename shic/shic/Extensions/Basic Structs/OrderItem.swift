//
//  OrderItem.swift
//  shic
//
//  Created by Руслан Парастаев on 07.10.2024.
//

import SwiftUI

struct OrderItem: View {
    
    var status: String
    var title: String
    var action: () -> Void
    var chat: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(status)
                .font(.custom("Alegreya-Bold", size: 16))
                .foregroundColor(Color.darkPrimary)
                .multilineTextAlignment(.leading)
                .padding(.leading, 16)
            
            Button {
                action()
            } label: {
                HStack(spacing: 16) {
                    Text(title)
                        .font(.custom("Alegreya-Regular", size: 12))
                        .foregroundColor(Color.darkPrimary)
                        .multilineTextAlignment(.leading)
            
                    Spacer()
                    Button {
                        chat()
                    } label: {
                        Image("ChatIcon")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.darkPrimary)
                    }
                    Button {
                        action()
                    } label: {
                        Image("FillRightArrow")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(Color.darkPrimary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.darkPrimary, lineWidth: 1)
                        .padding(1)
                )
            }
        }
    }
    
}
