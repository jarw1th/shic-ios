//
//  Address.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI

struct Address: Codable, Identifiable {
    
    var id: String = UUID().uuidString
    var name: String = ""
    var city: String = ""
    var street: String = ""
    var room: String = ""
    var intercom: String = ""
    var floor: String = ""
    
}
