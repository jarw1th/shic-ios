//
//  SmartFormParamsScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormParamsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValid: Bool = false
    
    @State private var height: String = ""
    @State private var weight: String = ""
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onChange(of: height) { _ in
                    checkAvailable()
                }
                .onChange(of: weight) { _ in
                    checkAvailable()
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                RouteManager.shared.pop(false)
                presentationMode.wrappedValue.dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Рост и вес", text: "Мы никому не скажем :)")
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
        VStack(spacing: 16) {
            FillField(type: .height, text: $height, placeholder: "100 см", name: "Рост")
            FillField(type: .weight, text: $weight, placeholder: "100 кг", name: "Вес")
        }
    }
    
    private func checkAvailable() {
        isValid = ValidManager.shared.checkHeightAndWeight(height) && ValidManager.shared.checkHeightAndWeight(weight)
    }
    
}
