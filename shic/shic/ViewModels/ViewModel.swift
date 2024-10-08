//
//  ViewModel.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    private var userDefaultsManager: UserDefaultsManager
    private var firebaseManager: FirebaseManager
    
    @Published var smartFormModel: SmartFormModel = SmartFormModel()
    @Published var styleFormModel: StyleFormModel = StyleFormModel()
    @Published var userModel: User = User(uid: UUID().uuidString)
    @Published var imagePacks: [[String]] = []
    
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
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchPreloadContent() {
        firebaseManager.fetchPreloadLovingImages { result in
            switch result {
            case .success(let urls):
                self.imagePacks = urls.split()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchForm(_ type: FormType) {
        firebaseManager.fetchSmartForm(for: userModel.uid, type: type) { result in
            switch result {
            case .success(let form):
                if let form = form as? StyleFormModel {
                    self.styleFormModel = form
                }
                if let form = form as? SmartFormModel {
                    self.smartFormModel = form
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func saveForm(_ type: FormType) {
        switch type {
        case .smart:
            firebaseManager.saveSmartForm(uuid: userModel.uid, type: type, form: smartFormModel)
        case .style:
            firebaseManager.saveSmartForm(uuid: userModel.uid, type: type, form: styleFormModel)
        }
    }
    
}
