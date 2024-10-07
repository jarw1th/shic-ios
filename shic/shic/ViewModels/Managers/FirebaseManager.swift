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
        let db = Firestore.firestore()
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
        let db = Firestore.firestore()

        do {
            try db.collection("users").document(user.uid).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
}
