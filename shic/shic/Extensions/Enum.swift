//
//  Enum.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

enum FillFieldType {
    
    case standart
    case date
    case phone
    
}


enum Gender: StringData, CaseIterable {
    
    case mail
    case femail
    case child
    
    func text() -> String {
        switch self {
        case .child:
            "Ребенок"
        case .femail:
            "Женщина"
        case .mail:
            "Мужчина"
        }
    }
    
}
