//
//  ViewModel.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    private var userDefaultsManager: UserDefaultsManager
    
    @Published var smartFormModel: SmartFormModel = SmartFormModel()
    @Published var userModel: UserModel = UserModel()
    
    init() {
        self.userDefaultsManager = UserDefaultsManager.shared
    }
    
}
