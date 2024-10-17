//
//  StartBannerStruct.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI
import ACarousel

struct Carousel: View {
    
    var items: [StartBanner]
    
    var body: some View {
        ACarousel(items,
                  spacing: 8,
                  headspace: 8,
                  sidesScaling: 1,
                  isWrap: true,
                  autoScroll: .active(10)) { item in
            if item.images.count > 0 {
                WebImage(url: URL(string: item.images[0]), content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }, placeholder: {
                    Placeholder()
                        .scaledToFit()
                        .clipped()
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
            }
        }
        .frame(height: 120)
    }
    
}
