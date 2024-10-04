//
//  ValidManager.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import Foundation

final class ValidManager {
    
    static let shared = ValidManager()
    
    func checkPhoneNumber(_ number: String) -> Bool {
        let phoneRegex = "^\\+7 \\d{3} \\d{3} \\d{2} \\d{2}$"
        
        let regex = try? NSRegularExpression(pattern: phoneRegex, options: [])
        
        let range = NSRange(location: 0, length: number.utf16.count)
        return regex?.firstMatch(in: number, options: [], range: range) != nil
    }
    
    func checkDate(_ date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let birthDate = dateFormatter.date(from: date) else { return false }
        
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        
        if let age = ageComponents.year, age >= 12 {
            return true
        } else {
            return false
        }
    }
    
    func checkCode(_ code: String, numbers: Int) -> Bool {
        let digits = code.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return code.count == digits.count && digits.count == numbers
    }
    
}
