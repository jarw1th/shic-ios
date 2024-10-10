//
//  StyleFormModel.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct StyleFormModel: Codable {
    
    var lovingImages: [String] = []
    var lovingColors: [String] = []
    var dislikedColors: [String] = []
    var dislikedItems: [DislikeItemsType] = []
    var patterns: [PatternType] = []
    
}
