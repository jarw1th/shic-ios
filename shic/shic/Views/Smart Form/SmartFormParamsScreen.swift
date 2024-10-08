//
//  SmartFormParamsScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormParamsScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onChange(of: viewModel.smartFormModel.height) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.smartFormModel.weight) { _ in
                    checkAvailable()
                }
                .onAppear {
                    checkAvailable()
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                SmartFormRouteManager.shared.pop()
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Рост и вес", text: "Мы никому не скажем :)")
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
        VStack(spacing: 16) {
            FillField(type: .height, text: $viewModel.smartFormModel.height, placeholder: "100 см", name: "Рост")
            FillField(type: .weight, text: $viewModel.smartFormModel.weight, placeholder: "100 кг", name: "Вес")
        }
    }
    
    private func checkAvailable() {
        isValid = ValidManager.shared.checkHeightAndWeight(viewModel.smartFormModel.height) && ValidManager.shared.checkHeightAndWeight(viewModel.smartFormModel.weight)
    }
    
}
