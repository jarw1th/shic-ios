//
//  SmartFormGender.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct SmartFormGenderScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onAppear {
                    checkAvailable()
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                SmartFormRouteManager.shared.pop(false)
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Пол")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid, isImportant: true)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        PickerMenu(data: Gender.allCases, placeholder: "выбери", header: "Я ", selectedData: $viewModel.smartFormModel.gender) { 
            checkAvailable()
        }
    }
    
    private func checkAvailable() {
        isValid = viewModel.smartFormModel.gender != nil
    }
    
}
