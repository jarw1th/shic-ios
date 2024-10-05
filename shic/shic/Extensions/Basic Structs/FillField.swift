//
//  FillField.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct FillField: View {
    
    var type: FillFieldType = .standart
    @Binding var text: String
    var placeholder: String
    var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
                .font(.custom("Alegreya-Bold", size: 16))
                .foregroundColor(Color.darkPrimary)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.custom("Alegreya-Regular", size: 16))
                        .foregroundColor(Color.darkPrimary.opacity(0.4))
                        .multilineTextAlignment(.leading)
                }
                TextField("", text: $text)
                    .keyboardType(type == .standart ? .default : .numberPad)
                    .autocapitalization(.sentences)
                    .disableAutocorrection(true)
                    .font(.custom("Alegreya-Regular", size: 16))
                    .foregroundStyle(Color.darkPrimary)
                    .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.darkPrimary, lineWidth: 1)
                    .opacity(!text.isEmpty ? 1.0 : 0.4)
            )
        }
        .onChange(of: text) { newValue in
            if type == .phone, !newValue.isEmpty {
                text = formatPhoneNumber(newValue)
            }
            if type == .date, !newValue.isEmpty {
                text = formatDate(newValue)
            }
        }
    }
    
    private func formatPhoneNumber(_ number: String) -> String {
        let cleaned = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let prefix = "+7 "
        var formattedNumber = ""
        
        let hasPrefix = cleaned.hasPrefix("7")
        let adjustedCleanedNumber = hasPrefix ? String(cleaned.dropFirst()) : cleaned
        
        if adjustedCleanedNumber.isEmpty {
            return prefix
        }

        let firstPart = String(adjustedCleanedNumber.prefix(3))
        let secondPart = String(adjustedCleanedNumber.dropFirst(3).prefix(3))
        let thirdPart = String(adjustedCleanedNumber.dropFirst(6).prefix(2))
        let fourthPart = String(adjustedCleanedNumber.dropFirst(8).prefix(2))

        formattedNumber += firstPart.isEmpty ? "" : "\(firstPart) "
        formattedNumber += secondPart.isEmpty ? "" : "\(secondPart) "
        formattedNumber += thirdPart.isEmpty ? "" : "\(thirdPart) "
        formattedNumber += fourthPart.isEmpty ? "" : "\(fourthPart)"
        
        formattedNumber = formattedNumber.trimmingCharacters(in: .whitespaces)
        
        if number.last == " " {
            if !formattedNumber.isEmpty {
                formattedNumber = String(formattedNumber.dropLast())
            }
        }

        return prefix + formattedNumber
    }
    
    private func formatDate(_ date: String) -> String {
        let cleaned = date.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        var formattedDate = ""
        
        let dayPart = String(cleaned.prefix(2))
        let monthPart = String(cleaned.dropFirst(2).prefix(2))
        let yearPart = String(cleaned.dropFirst(4).prefix(4))
        
        if !dayPart.isEmpty {
            formattedDate += "\(dayPart)."
        }
        if !monthPart.isEmpty {
            formattedDate += "\(monthPart)."
        }
        if !yearPart.isEmpty {
            formattedDate += "\(yearPart)"
        }

        if isValidDate(day: dayPart, month: monthPart, year: yearPart) {
            return formattedDate
        } else {
            return String(formattedDate.dropLast())
        }
    }
    
    private func isValidDate(day: String, month: String, year: String) -> Bool {
        guard let dayInt = Int(day), let monthInt = Int(month), let yearInt = Int(year) else {
            return false
        }
        
        guard (1...12).contains(monthInt) else {
            return false
        }

        let daysInMonth: [Int] = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        let isLeapYear = (yearInt % 4 == 0 && yearInt % 100 != 0) || (yearInt % 400 == 0)
        let maxDays = (monthInt == 2 && isLeapYear) ? 29 : daysInMonth[monthInt]

        return (1...maxDays).contains(dayInt)
    }
    
}

