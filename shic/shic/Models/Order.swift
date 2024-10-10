//
//  Card.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI

struct Order: Codable, Identifiable {
    
    var id: String = UUID().uuidString
    
    var status: OrderStatus = .waiting
    var name: String = ""
    
    var price: String = ""
    var promo: String = ""
    
    var items: [Item] = []
    
    var address: Address = Address()
    var stylistID: String = ""
    var userID: String = ""
    
    var smartForm: SmartFormModel = SmartFormModel()
    var measureForm: MeasureFormModel = MeasureFormModel()
    var styleForm: StyleFormModel = StyleFormModel()
    
}
