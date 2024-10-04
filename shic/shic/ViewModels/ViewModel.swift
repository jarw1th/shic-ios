//
//  ViewModel.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    static let shared = ViewModel()
    
    private var userDefaultsManager: UserDefaultsManager
    
    init() {
        self.userDefaultsManager = UserDefaultsManager.shared
    }
    
}
