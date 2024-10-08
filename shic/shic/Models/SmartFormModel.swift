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
    var wearType: [WearType] = []
    
    var clothType: [ClothType] = []
    
    var specificBodyType: [SpecificBodyType] = []
    var specificBodyString: String = ""
    
    var accessories: [AccessoriesType] = []
    var jewelry: [JewelryType] = []
    
    var height: String = ""
    var weight: String = ""
    
    var bodyType: BodyType? = nil
    
    var shirt: ShirtModel = ShirtModel()
    var pants: PantsModel = PantsModel()
    var foot: FootModel = FootModel()
    var jacket: JacketModel = JacketModel()
    
    var brandType: [BrandType] = []
    
}

struct JacketModel: Codable {
    
    var sizes: [DefaultSizeTable] = []
    var sizeType: DefaultSizeType? = nil
    
    var colar: WidthSizeType? = nil
    var planting: PlantingType? = nil
    var sleeve: LengthSizeType? = nil
    
    var type: ShirtType? = nil
    var price: String = ""
    
}

struct ShirtModel: Codable {
    
    var sizes: [DefaultSizeTable] = []
    var sizeType: DefaultSizeType? = nil
    
    var colar: WidthSizeType? = nil
    var shoulders: WidthSizeType? = nil
    var sleeve: LengthSizeType? = nil
    var waist: WidthSizeType? = nil
    
    var type: ShirtType? = nil
    var price: String = ""
    
}

struct PantsModel: Codable {
    
    var sizes: [DefaultSizeTable] = []
    var sizeType: DefaultSizeType? = nil
    
    var planting: PlantingType? = nil
    var width: WidthSizeType? = nil
    var length: LengthSizeType? = nil
    
    var type: PantsType? = nil
    var price: String = ""
    
}

struct FootModel: Codable {
    
    var sizes: String = ""
    var sizeType: DefaultSizeType? = nil
    
    var planting: PlantingType? = nil
    
    var type: [FootType] = []
    var price: String = ""
    
}

