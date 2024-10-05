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

enum WearStyle: StringData, CaseIterable {
    
    case casual
    case business
    case sporty
    case street
    case romantic
    case party
    case classic
    
    func text() -> String {
        switch self {
        case .casual:
            "Кэжуал"
        case .business:
            "Деловой"
        case .sporty:
            "Спортивный"
        case .street:
            "Стрит"
        case .romantic:
            "Свидание"
        case .party:
            "Вечеринки"
        case .classic:
            "Классический"
        }
    }
    
}
