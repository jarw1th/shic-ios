//
//  DataManager.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

final class DataManager {
    
    static let shared = DataManager()
    
    private let colors: [String: String] = ["Красный": Color.red.toHex(), "Голубой": Color.blue.toHex(), "Зеленый": Color.green.toHex(), "Желтый": Color.yellow.toHex(),
                                            "Фиолетовый": Color.purple.toHex()]
    
    func getColors() -> [String: String] {
        colors
    }
    
}
