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
    
    // Banners
    @Published var promoBanner: [PromoBanner] = []
    @Published var start: StartBanner = StartBanner()
    
    // User
    @Published var userModel: User = User(uid: UUID().uuidString)
    @Published var userPromos: [Promo] = []
    
    // Content
    @Published var imagePacks: [[String]] = []
    @Published var promo: Promo = Promo()
    
    // UI
    @Published var isTabBarHidded: Bool = false
    
    init() {
        self.userDefaultsManager = UserDefaultsManager.shared
        self.firebaseManager = FirebaseManager.shared
        fetchUser()
    }
    
    func saveUser() {
        UserDefaultsManager.shared.testLoginInfo = userModel.uid
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
    
    func saveNewOrder() {
        order.id = generateShortOrderNumber()
        order.name = generateShortOrderNumber()
        order.userID = userModel.uid
        order.smartForm = smartFormModel
        order.measureForm = measureFormModel
        order.styleForm = styleFormModel
        order.startDate = getTodayDate()
        firebaseManager.saveOrder(order: order)
    }
    
    func cancelOrder() {
        order.status = .canceled
        order.endDate = getTodayDate()
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
    
    func fetchBanners() {
        firebaseManager.fetchStartBanner { result in
            switch result {
            case .success(let banner):
                self.start = banner
            case .failure(let error):
                print(error)
                break
            }
        }
        firebaseManager.fetchPromoBanners { result in
            switch result {
            case .success(let banners):
                self.promoBanner = banners
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchDiscount() {
        firebaseManager.fetchContentPromo(for: order.promo) { result in
            switch result {
            case .success(let promo):
                self.order.discount = Double(promo.discount) / 100
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func checkPromo(_ promo: String) -> Bool {
        fetchUserPromos()
        fetchContentPromo(promo)
        if let userPromo = userPromos.filter({ $0.name == promo }).first,
           userPromo.uses < userPromo.total {
            return true
        } else if !userPromos.contains(where: { $0.name == promo }) {
            return true
        } else {
            return false
        }
    }
    
    func updatePromo() {
        if var userPromo = userPromos.filter({ $0.name == order.promo }).first {
            userPromo.uses += 1
            firebaseManager.saveUserPromo(for: userModel.uid, with: userPromo)
        }
    }
    
    private func fetchUserPromos() {
        firebaseManager.fetchUserPromos(for: userModel.uid) { result in
            switch result {
            case .success(let promos):
                self.userPromos = promos
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func fetchContentPromo(_ text: String) {
        firebaseManager.fetchContentPromo(for: text) { result in
            switch result {
            case .success(let promo):
                self.promo = promo
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func generateShortOrderNumber() -> String {
        let timestamp = Int(Date().timeIntervalSince1970.truncatingRemainder(dividingBy: 100000))
        let randomSuffix = Int.random(in: 100..<999)
        return "SHIC\(timestamp)\(randomSuffix)"
    }
    
    private func getTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: Date())
    }
    
}
