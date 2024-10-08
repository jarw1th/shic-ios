//
//  DataManager.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

final class DataManager {
    
    static let shared = DataManager()
    
    private let colors: [String: Color] = ["Красный": .red, "Голубой": .blue, "Зеленый": .green, "Желтый": .yellow, "Фиолетовый": .purple]
    
    func getColors() -> [String: Color] {
        colors
    }
    
}
