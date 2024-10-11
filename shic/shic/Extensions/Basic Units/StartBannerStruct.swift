//
//  StartBannerStruct.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct StartBannerStruct: View {
    
    var banner: StartBanner
    
    var body: some View {
        HStack(spacing: 16) {
            if banner.images.count > 0 {
                WebImage(url: URL(string: banner.images[0]), content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 320)
                        .cornerRadius(200)
                }, placeholder: {
                    Placeholder()
                        .scaledToFit()
                        .frame(width: 100, height: 320)
                        .cornerRadius(200)
                })
            }
            VStack(alignment: .leading, spacing: 16) {
                if banner.images.count > 1 {
                    WebImage(url: URL(string: banner.images[1]), content: { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 140)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(200)
                    }, placeholder: {
                        Placeholder()
                            .scaledToFit()
                            .frame(height: 140)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(200)
                    })
                }
                VStack {
                    Spacer()
                    Text(banner.text)
                        .font(Font.custom("Alegreya-Regular", size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.darkPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .frame(height: 164)
            }
        }
    }
    
}
