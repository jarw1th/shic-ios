//
//  ActionBanner.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct PromoBanner: Codable, Identifiable {
    
    var id: String = UUID().uuidString
    var image: String = ""
    var title: String = ""
    var promo: String = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decode(String.self, forKey: .image)
        self.title = try container.decode(String.self, forKey: .title)
        self.promo = try container.decode(String.self, forKey: .promo)
    }
    
    init()  {}
    
}
