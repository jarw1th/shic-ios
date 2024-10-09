//
//  SmartFormRouteManager.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

final class SmartFormRouteManager {
    
    static let shared = SmartFormRouteManager()
    
    private(set) var formIndex: Int
    private(set) var formScreens: [String]
    
    init() {
        self.formIndex = 0
        self.formScreens = ["SmartFormGenderScreen", "SmartFormParamsScreen", "SmartFormBodyTypeScreen", "SmartFormSpecificBodyScreen", "SmartFormWearStyleScreen",
                            "SmartFormClothScreen", "SmartFormSizesScreen", "SmartFormJacketScreen", "SmartFormShirtScreen", "SmartFormPantsScreen", "SmartFormFootScreen",
                            "SmartFormWearTypeScreen", "SmartFormFootAccessoriesScreen", "SmartFormBudgetScreen"]
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
