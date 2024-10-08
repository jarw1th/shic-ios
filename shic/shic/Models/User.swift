//
//  UserModel.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct User: Codable {
    
    var uid: String
    var name: String = ""
    var birthday: String = ""
    var phone: String = ""
    var surname: String = ""
    var email: String = ""
    var isAccepted: Bool = false
    var isSmartFormFill: Bool = false
    var isStyleFormFill: Bool = false
    
}
