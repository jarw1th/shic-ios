//
//  StyleFormRouteManager.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

final class StyleFormRouteManager {
    
    static let shared = StyleFormRouteManager()
    
    private(set) var formIndex: Int
    private(set) var formScreens: [String]
    
    init() {
        self.formIndex = 0
        self.formScreens = ["StyleFormLikeScreen0", "StyleFormColorScreen"]
    }
    
    func pop() {
        formIndex -= 1
    }
    
    func push() {
        formIndex += 1
    }
    
    func clear() {
        formIndex = 0
    }
    
}
