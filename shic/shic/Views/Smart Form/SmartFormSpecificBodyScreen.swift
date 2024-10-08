//
//  SmartFormSpecificBodyScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormSpecificBodyScreen: View {
    
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
                SmartFormRouteManager.shared.pop()
                dismiss()
            }
            VStack(spacing: 40) {
                TopHeaderText(header: "Особенности тела", text: "Есть ли у тебя какие-то особенности тела?")
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
            PickerSeveralItems(data: SpecificBodyType.allCases, rows: 3, selectedData: $viewModel.smartFormModel.specificBodyType) {
                checkAvailable()
            }
            FillField(text: $viewModel.smartFormModel.specificBodyString, placeholder: "Хочу скрыть мои полные бедра", name: "Хотите что-то подчеркнуть или скрыть?")
        }
    }
    
    private func checkAvailable() {
        isValid = !viewModel.smartFormModel.specificBodyType.isEmpty
    }
    
}
