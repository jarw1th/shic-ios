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
    case email
    case height
    case weight
    case footSize
    
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

enum BodyType: StringData, CaseIterable {
    
    case inverted
    case triangle
    case slim
    case oval
    
    func text() -> String {
        switch self {
        case .inverted:
            "Обратный треугольник"
        case .triangle:
            "Треугольник"
        case .slim:
            "Худой"
        case .oval:
            "Овальная форма"
        }
    }
    
}

enum DefaultSizeTable: StringData, CaseIterable {
    
    case xs
    case s
    case m
    case l
    case xl
    case xxl
    case xxxl
    
    func text() -> String {
        switch self {
        case .xs:
            "XS"
        case .s:
            "S"
        case .m:
            "M"
        case .l:
            "L"
        case .xl:
            "XL"
        case .xxl:
            "XXL"
        case .xxxl:
            "3L"
        }
    }
    
}

enum DefaultSizeType: StringData, CaseIterable {
    
    case little
    case perfect
    case big
    
    func text() -> String {
        switch self {
        case .little:
            "Маломерят"
        case .perfect:
            "Идеально"
        case .big:
            "Большемерят"
        }
    }
    
}

enum WidthSizeType: StringData, CaseIterable {
    
    case tight
    case perfect
    case wide
    
    func text() -> String {
        switch self {
        case .tight:
            "Обычно узко"
        case .perfect:
            "Идеально"
        case .wide:
            "Обычно широко"
        }
    }
    
}

enum LengthSizeType: StringData, CaseIterable {
    
    case short
    case perfect
    case long
    
    func text() -> String {
        switch self {
        case .short:
            "Обычно коротко"
        case .perfect:
            "Идеально"
        case .long:
            "Обычно длинные"
        }
    }
    
}
