//
//  DataManager.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

final class DataManager {
    
    static let shared = DataManager()
    
    private let colors: [String: String] = ["Красный": Color.red.toHex(), "Синий": Color.blue.toHex(), "Зеленый": Color.green.toHex(), "Желтый": Color.yellow.toHex(),
                                            "Фиолетовый": Color.purple.toHex(), "Розовый": Color.pink.toHex(), "Оранжевый": Color.pink.toHex(), "Серый": Color.gray.toHex(),
                                            "Белый": Color.white.toHex(), "Чёрный": Color.black.toHex()]
    private let imageNames: [String] = ["image.jpg", "image-2.jpg", "image-3.jpg", "image-4.jpg"]
    
    func getColors() -> [String: String] {
        colors
    }
    
    func getImageNames() -> [String] {
        imageNames
    }
    
}
