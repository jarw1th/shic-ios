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
    @Published var styleFormModel: StyleFormModel = StyleFormModel()
    @Published var userModel: UserModel = UserModel()
    @Published var imagePacks: [[Image]] = []
    
    init() {
        self.userDefaultsManager = UserDefaultsManager.shared
    }
    
}
