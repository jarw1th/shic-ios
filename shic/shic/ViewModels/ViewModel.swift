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
    
    // Orders
    @Published var orders: [Order] = []
    @Published var doneOrders: [Order] = []
    @Published var order: Order = Order()
    
    // Forms
    @Published var smartFormModel: SmartFormModel = SmartFormModel()
    @Published var styleFormModel: StyleFormModel = StyleFormModel()
    @Published var measureFormModel: MeasureFormModel = MeasureFormModel()
    
    // Addresses
    @Published var addresses: [Address] = []
    @Published var address: Address = Address()
    
    @Published var userModel: User = User(uid: UUID().uuidString)
    @Published var imagePacks: [[String]] = []
    
    @Published var isTabBarHidded: Bool = false
    
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
        firebaseManager.fetchPreloadLovingImages { images in
            self.imagePacks = images
        }
    }
    
    func fetchForm(_ type: FormType) {
        firebaseManager.fetchForm(for: userModel.uid, type: type) { result in
            switch result {
            case .success(let form):
                if let form = form as? StyleFormModel {
                    self.styleFormModel = form
                }
                if let form = form as? SmartFormModel {
                    self.smartFormModel = form
                }
                if let form = form as? MeasureFormModel {
                    self.measureFormModel = form
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
            firebaseManager.saveForm(uuid: userModel.uid, type: type, form: smartFormModel)
        case .style:
            firebaseManager.saveForm(uuid: userModel.uid, type: type, form: styleFormModel)
        case .measure:
            firebaseManager.saveForm(uuid: userModel.uid, type: type, form: measureFormModel)
        }
    }
    
    func saveAddress() {
        firebaseManager.saveAddress(uuid: userModel.uid, address: address)
    }
    
    func removeAddress() {
        firebaseManager.removeAddress(uuid: userModel.uid, address: address)
    }
    
    func fetchAddresses() {
        firebaseManager.fetchAddresses(for: userModel.uid) { result in
            switch result {
            case .success(let addresses):
                self.addresses = addresses
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func newAddress() {
        address = Address()
    }
    
    func saveOrder() {
        firebaseManager.saveOrder(order: order)
    }
    
    func fetchOrders() {
        firebaseManager.fetchOrders(for: userModel.uid) { result in
            switch result {
            case .success(let orders):
                self.orders = orders.filter({ $0.status != .canceled })
                self.doneOrders = orders.filter({ $0.status == .canceled })
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func newOrder() {
        order = Order()
    }
    
}
