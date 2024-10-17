//
//  FirebaseManager.swift
//  shic
//
//  Created by Руслан Парастаев on 07.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private let imgNumber = 8
    
    func fetchUserData(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        let docRef = db.collection("users").document(uid)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let user = try? document.data(as: User.self) {
                    completion(.success(user))
                } else {
                    completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                }
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
    }
    
    func saveUserData(user: User) {
        do {
            try db.collection("users").document(user.uid).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func fetchPreloadLovingImages(completion: @escaping ([[String]]) -> Void) {
        var images: [[String]] = []
        let dispatchGroup = DispatchGroup()
        
        for number in 1...imgNumber {
            dispatchGroup.enter()
            
            getImageUrl(for: number) { url in
                images.append(url)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(images)
        }
    }
    
    private func getImageUrl(for number: Int, completion: @escaping ([String]) -> Void) {
        var images: [String] = []
        let dispatchGroup = DispatchGroup()
        
        for name in DataManager.shared.getImageNames() {
            dispatchGroup.enter()
            getImageUrl(imageName: name, number: number) { url in
                images.append(url)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(images)
        }
    }
    
    private func getImageUrl(imageName: String, number: Int, completion: @escaping (String) -> Void) {
        let storageRef = storage.reference()

        let imageRef = storageRef.child("StyleFormImages/\(number)/\(imageName)")

        imageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error getting download URL: \(error.localizedDescription)")
                completion("")
                return
            }
            
            if let downloadURL = url {
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    func saveForm<T: Codable>(uuid: String, type: FormType, form: T) {
        fetchLastDocumentID(for: uuid, and: type) { result in
            switch result {
            case .success(let id):
                try? self.db.collection("users").document(uuid).collection(type.firebaseID()).document(String(id)).setData(from: form)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchForm(for uuid: String, type: FormType, completion: @escaping (Result<Codable, Error>) -> Void) {
        fetchLastDocumentID(for: uuid, and: type) { result in
            switch result {
            case .success(let id):
                let docRef = self.db.collection("users").document(uuid).collection(type.firebaseID()).document(String(id))
                
                docRef.getDocument { document, error in
                    if let document = document, document.exists {
                        switch type {
                        case .smart:
                            if let smartForm = try? document.data(as: SmartFormModel.self) {
                                completion(.success(smartForm))
                            } else {
                                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                            }
                        case .style:
                            if let styleForm = try? document.data(as: StyleFormModel.self) {
                                completion(.success(styleForm))
                            } else {
                                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                            }
                        case .measure:
                            if let measureForm = try? document.data(as: MeasureFormModel.self) {
                                completion(.success(measureForm))
                            } else {
                                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                            }
                        }
                    } else {
                        completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchLastDocumentID(for uuid: String, and type: FormType, completion: @escaping (Result<Int, Error>) -> Void) {
        let collectionRef = db.collection("users").document(uuid).collection(type.firebaseID())

        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = snapshot?.documents else {
                completion(.success(0))
                return
            }

            let ids = documents.compactMap { Int($0.documentID) }
            let lastID = ids.max() ?? 0

            completion(.success(lastID))
        }
    }
    
    func saveAddress(uuid: String, address: Address) {
        if !address.id.isEmpty {
            do {
                try db.collection("users").document(uuid).collection("addresses").document(address.id).setData(from: address)
            } catch let error {
                print("Error writing user to Firestore: \(error)")
            }
        }
    }
    
    func removeAddress(uuid: String, address: Address) {
        if !address.id.isEmpty {
            db.collection("users").document(uuid).collection("addresses").document(address.id).delete()
        }
    }
    
    func fetchAddresses(for uuid: String, completion : @escaping (Result<[Address], Error>) -> Void) {
        let docRef = db.collection("users").document(uuid).collection("addresses")
        
        docRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let addresses: [Address] = documents.compactMap { document in
                try? document.data(as: Address.self)
            }
            
            completion(.success(addresses))
        }
    }
    
    func saveOrder(order: Order) {
        guard !order.id.isEmpty else { return }
        
        do {
            try db.collection("users").document(order.userID).collection("orders").document(order.id).setData(from: order)
//            try db.collection("stylists").document(order.stylistID).collection("orders").document(order.id).setData(from: order)
            try db.collection("orders").document(order.id).setData(from: order)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func fetchOrders(for uuid: String, completion : @escaping (Result<[Order], Error>) -> Void) {
        let docRef = db.collection("users").document(uuid).collection("orders")
        
        docRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let orders: [Order] = documents.compactMap { document in
                try? document.data(as: Order.self)
            }
            
            completion(.success(orders))
        }
    }
    
    // Banners
    func fetchStartBanner(completion : @escaping (Result<StartBanner, Error>) -> Void) {
        let docRef = db.collection("content").document("homeScreen")
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let banner = try? document.data(as: StartBanner.self) {
                    completion(.success(banner))
                } else {
                    completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                }
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
    }
    
    func fetchPromoBanners(completion : @escaping (Result<[PromoBanner], Error>) -> Void) {
        let docRef = db.collection("content").document("homeScreen").collection("promo")
        
        docRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let banners: [PromoBanner] = documents.compactMap { document in
                try? document.data(as: PromoBanner.self)
            }
            
            completion(.success(banners))
        }
    }
    
    func fetchContentPromo(for promo: String, completion : @escaping (Result<Promo, Error>) -> Void) {
        let docRef = db.collection("promos").document(promo)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let promo = try? document.data(as: Promo.self) {
                    completion(.success(promo))
                } else {
                    completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                }
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
    }
    
    func fetchUserPromos(for uuid: String, completion : @escaping (Result<[Promo], Error>) -> Void) {
        let docRef = db.collection("users").document(uuid).collection("promos")
        
        docRef.getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let promos: [Promo] = documents.compactMap { document in
                try? document.data(as: Promo.self)
            }
            
            completion(.success(promos))
        }
    }
    
    func saveUserPromo(for uuid: String, with promo: Promo) {
        do {
            try db.collection("users").document(uuid).collection("promos").document(promo.name).setData(from: promo)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
}
