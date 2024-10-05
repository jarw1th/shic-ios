//
//  SmartFormGender.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct SmartFormGenderScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValid: Bool = false
    
    @State private var gender: Gender? = nil
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                RouteManager.shared.pop(false)
                presentationMode.wrappedValue.dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Пол")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        PickerMenu(data: Gender.allCases, placeholder: "выбери", header: "Я ") { data in
            gender = data
            if gender != nil {
                isValid = true
            }
        }
    }
    
}
