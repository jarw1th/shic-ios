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
        let cleaned = date.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let day = String(cleaned.prefix(2))
        let month = String(cleaned.dropFirst(2).prefix(2))
        let year = String(cleaned.dropFirst(4).prefix(4))
        
        guard let dayInt = Int(day), let monthInt = Int(month), let yearInt = Int(year) else {
            return false
        }
        
        guard (1...12).contains(monthInt) else {
            return false
        }

        let daysInMonth: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        let isLeapYear = (yearInt % 4 == 0 && yearInt % 100 != 0) || (yearInt % 400 == 0)
        let maxDays = (monthInt == 2 && isLeapYear) ? 29 : daysInMonth[monthInt]
        
        guard (1...maxDays).contains(dayInt) && yearInt >= 1900 else {
            return false
        }
        
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        let birthDateComponents = DateComponents(year: yearInt, month: monthInt, day: dayInt)
        guard let birthDate = calendar.date(from: birthDateComponents) else {
            return false
        }

        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        guard let age = ageComponents.year else {
            return false
        }

        return age >= 12
    }
    
    func checkCode(_ code: String, numbers: Int) -> Bool {
        let digits = code.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return code.count == digits.count && digits.count == numbers
    }
    
    func checkHeightAndWeight(_ value: String) -> Bool {
        let digits = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return !digits.isEmpty
    }
    
    func checkEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
}
