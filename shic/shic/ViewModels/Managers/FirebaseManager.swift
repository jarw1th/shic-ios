//
//  FirebaseManager.swift
//  shic
//
//  Created by Руслан Парастаев on 07.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let db = Firestore.firestore()
    
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
    
    func fetchPreloadLovingImages(completion: @escaping (Result<[String], Error>) -> Void) {
        let docRef = db.collection("content").document("lovingImages")

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let data = document.data(), let images = data["urls"] as? [String] {
                    completion(.success(images))
                } else {
                    completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse images"])))
                }
            } else {
                completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
            }
        }
    }
    
    func saveSmartForm<T: Codable>(uuid: String, type: FormType, form: T) {
        fetchLastDocumentID(for: uuid, and: type) { result in
            switch result {
            case .success(let id):
                try? self.db.collection("users").document(uuid).collection(type.firebaseID()).document(String(id)).setData(from: form)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchSmartForm(for uuid: String, type: FormType, completion: @escaping (Result<Codable, Error>) -> Void) {
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
        let db = Firestore.firestore()
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
    
}
