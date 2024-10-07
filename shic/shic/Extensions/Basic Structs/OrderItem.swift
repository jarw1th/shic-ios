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
        VStack(alignment: .leading, spacing: 0) {
            Text(status)
                .font(.custom("Alegreya-Bold", size: 16))
                .foregroundColor(Color.darkPrimary)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
            
            Button {
                action()
            } label: {
                HStack(spacing: 16) {
                    Text(title)
                        .font(.custom("Alegreya-Regular", size: 16))
                        .foregroundColor(Color.darkPrimary)
                        .multilineTextAlignment(.leading)
            
                    Spacer()
                    Button {
                        chat()
                    } label: {
                        Image("ChatIcon")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.darkPrimary)
                    }
                    Button {
                        action()
                    } label: {
                        Image("FillRightArrow")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color.darkPrimary)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.darkPrimary, lineWidth: 1)
                        .padding(1)
                )
            }
        }
    }
    
}
