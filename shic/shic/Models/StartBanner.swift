//
//  StartBanner.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct StartBanner: Codable {
    
    var id: String = UUID().uuidString
    var images: [String] = []
    var text: String = ""
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.images = try container.decode([String].self, forKey: .images)
        self.text = try container.decode(String.self, forKey: .text)
    }
    
    init()  {}
    
}
