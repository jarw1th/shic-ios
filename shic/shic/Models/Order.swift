//
//  Card.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI

struct Order: Codable, Identifiable {
    
    var id: String = ""
    
    var status: OrderStatus = .waiting
    var name: String = ""
    
    var delivery: String = ""
    var prepay: String = ""
    var price: String = ""
    var promo: String = ""
    var discount: Double = 0.0
    
    var items: [Item] = []
    
    var address: Address?
    var stylistID: String = ""
    var userID: String = ""
    
    var startDate: String = ""
    var endDate: String = ""
    
    var smartForm: SmartFormModel = SmartFormModel()
    var measureForm: MeasureFormModel = MeasureFormModel()
    var styleForm: StyleFormModel = StyleFormModel()
    
}
