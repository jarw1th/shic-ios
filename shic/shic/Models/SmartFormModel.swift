//
//  SmartFormModel.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormModel: Codable {
    
    var gender: Gender? = nil
    
    var wearStyle: [WearStyle] = []
    
    var height: String = ""
    var weight: String = ""
    
    var bodyType: BodyType? = nil
    
    var shirt: ShirtModel = ShirtModel()
    var pants: PantsModel = PantsModel()
    var foot: FootModel = FootModel()
    
}

struct ShirtModel: Codable {
    
    var sizes: [DefaultSizeTable] = []
    var sizeType: DefaultSizeType? = nil
    
    var colar: WidthSizeType? = nil
    var shoulders: WidthSizeType? = nil
    var sleeve: LengthSizeType? = nil
    
    var type: ShirtType? = nil
    
}

struct PantsModel: Codable {
    
    var sizes: [DefaultSizeTable] = []
    var sizeType: DefaultSizeType? = nil
    
    var type: PantsType? = nil
    
}

struct FootModel: Codable {
    
    var sizes: String = ""
    var sizeType: DefaultSizeType? = nil
    
}

