//
//  BasicFeedItem.swift
//  shic
//
//  Created by Руслан Парастаев on 09.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct BasicFeedItem: View {
    
    var title: String
    var image: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                WebImage(url: URL(string: image), content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 200)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.darkPrimary)
                                .padding(1)
                        )
                }, placeholder: {
                    Placeholder()
                        .cornerRadius(200)
                })
                
                Text(title)
                    .underline()
                    .font(.custom("Alegreya-Regular", size: 16))
                    .foregroundColor(Color.darkPrimary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 80)
                    .stroke(Color.darkPrimary, lineWidth: 1)
                    .padding(1)
            )
        }
    }
    
}
