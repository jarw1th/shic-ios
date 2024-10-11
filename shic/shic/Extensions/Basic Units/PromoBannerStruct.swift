//
//  PromoBanner.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PromoBannerStruct: View {
    
    var banner: PromoBanner
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                WebImage(url: URL(string: banner.image), content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .cornerRadius(200)
                }, placeholder: {
                    Placeholder()
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .cornerRadius(200)
                })
                
                Text(banner.title)
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
