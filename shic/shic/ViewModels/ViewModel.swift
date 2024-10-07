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
    private var firebaseManager: FirebaseManager
    
    @Published var smartFormModel: SmartFormModel = SmartFormModel()
    @Published var styleFormModel: StyleFormModel = StyleFormModel()
    @Published var userModel: User = User(uid: UUID().uuidString)
    @Published var imagePacks: [[Image]] = []
    
    init() {
        self.userDefaultsManager = UserDefaultsManager.shared
        self.firebaseManager = FirebaseManager.shared
        fetchUser()
    }
    
    func saveUser() {
        firebaseManager.saveUserData(user: userModel)
    }
    
    func fetchUser() {
        firebaseManager.fetchUserData(uid: userModel.uid) { result in
            switch result {
            case .success(let user):
                self.userModel = user
                print(user)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
