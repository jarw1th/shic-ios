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
    case budget
    
}

enum TabType {
    
    case home
    case orders
    case profile
    
}

enum ShapeType {
    
    case color
    case image
    
}

enum FormType {
    
    case smart
    case style
    
    func firebaseID() -> String {
        switch self {
        case .smart:
            "smartForm"
        case .style:
            "styleForm"
        }
    }
    
}


enum Gender: String, Codable, StringData, CaseIterable {
    
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

enum WearStyle: String, Codable, StringData, CaseIterable {
    
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

enum WearType: String, Codable, StringData, CaseIterable {
    
    case jeans
    case dresses
    case costumes
    case sport
    case shirts
    case skirts
    case shorts
    
    func text() -> String {
        switch self {
        case .jeans:
            "Джинсы"
        case .dresses:
            "Платья"
        case .costumes:
            "Костюмы"
        case .sport:
            "Спортивная одежда"
        case .shirts:
            "Рубашки"
        case .skirts:
            "Юбки"
        case .shorts:
            "Шорты"
        }
    }
    
}

enum ClothType: String, Codable, StringData, CaseIterable {
    
    case cotton
    case wool
    case leather
    case flax
    case silk
    case other
    
    func text() -> String {
        switch self {
        case .cotton:
            "Хлопок"
        case .wool:
            "Шерсть"
        case .leather:
            "Кожа"
        case .flax:
            "Лен"
        case .silk:
            "Шелк"
        case .other:
            "Другие"
        }
    }
    
}

enum AccessoriesType: String, Codable, StringData, CaseIterable {
    
    case scarf
    case bag
    case glasses
    case belt
    case hat
    case watch
    
    func text() -> String {
        switch self {
        case .scarf:
            "Шарфы"
        case .bag:
            "Сумки"
        case .glasses:
            "Очки"
        case .belt:
            "Ремни"
        case .hat:
            "Шляпы"
        case .watch:
            "Часы"
        }
    }
    
}

enum JewelryType: String, Codable, StringData, CaseIterable {
    
    case gold
    case silver
    case minimalistism
    case massive
    
    func text() -> String {
        switch self {
        case .gold:
            "Золото"
        case .silver:
            "Серебро"
        case .minimalistism:
            "Минимализм"
        case .massive:
            "Массивные"
        }
    }
    
}

enum DislikeItemsType: String, Codable, StringData, CaseIterable {
    
    case shorts
    case miniskirts
    case tightfitting
    case lowlanding
    
    func text() -> String {
        switch self {
        case .shorts:
            "Шорты"
        case .miniskirts:
            "Мини-юбки"
        case .tightfitting:
            "Обтягивающая одежда"
        case .lowlanding:
            "С низкой посадкой"
        }
    }
    
}

enum FootType: String, Codable, StringData, CaseIterable {
    
    case sneakers
    case shoes
    case boots
    case sandals
    case other
    
    func text() -> String {
        switch self {
        case .sneakers:
            "Кроссовки"
        case .shoes:
            "Туфли"
        case .boots:
            "Ботинки"
        case .sandals:
            "Сандали"
        case .other:
            "Другое"
        }
    }
    
}

enum SpecificBodyType: String, Codable, StringData, CaseIterable {
    
    case wideShoulder
    case longLegs
    case fatThighs
    case fatBelly
    case no
    
    func text() -> String {
        switch self {
        case .wideShoulder:
            "Широкие плечи"
        case .longLegs:
            "Длинные ноги"
        case .fatThighs:
            "Полные бедра"
        case .fatBelly:
            "Полный живот"
        case .no:
            "Нет"
        }
    }
    
}

enum BodyType: String, Codable, StringData, CaseIterable {
    
    case inverted
    case triangle
    case clock
    case slim
    case oval
    
    func text() -> String {
        switch self {
        case .inverted:
            "Обратный треугольник"
        case .triangle:
            "Треугольник"
        case .clock:
            "Песочные часы"
        case .slim:
            "Худой"
        case .oval:
            "Овальная форма"
        }
    }
    
}

enum DefaultSizeTable: String, Codable, StringData, CaseIterable {
    
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

enum DefaultSizeType: String, Codable, StringData, CaseIterable {
    
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

enum WidthSizeType: String, Codable, StringData, CaseIterable {
    
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

enum LengthSizeType: String, Codable, StringData, CaseIterable {
    
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

enum PlantingType: String, Codable, StringData, CaseIterable {
    
    case tight
    case perfect
    case free
    
    func text() -> String {
        switch self {
        case .tight:
            "Обычно облегает"
        case .perfect:
            "Идеально"
        case .free:
            "Обычно свободно"
        }
    }
    
}

enum ShirtType: String, Codable, StringData, CaseIterable {
    
    case tight
    case classic
    case oversize
    
    func text() -> String {
        switch self {
        case .tight:
            "Узкая"
        case .classic:
            "Классика"
        case .oversize:
            "Оверсайз"
        }
    }
    
}

enum PantsType: String, Codable, StringData, CaseIterable {
    
    case skinny
    case tight
    case athletic
    case oversize
    
    func text() -> String {
        switch self {
        case .skinny:
            "Скини"
        case .tight:
            "Узкие"
        case .athletic:
            "Атлетичные"
        case .oversize:
            "Оверсайз"
        }
    }
    
}

enum BrandType: String, Codable, StringData, CaseIterable {
    
    case maag
    case dap
    case nike
    case adidas
    case gucci
    case puma
    
    func text() -> String {
        switch self {
        case .maag:
            "MAAG"
        case .dap:
            "DAP"
        case .nike:
            "Nike"
        case .adidas:
            "Adidas"
        case .gucci:
            "Gucci"
        case .puma:
            "Puma"
        }
    }
    
}
