//
//  SmartFormWearStyleScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct SmartFormWearStyleScreen: View {
    
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
            VStack(spacing: 64) {
                TopHeaderText(header: "Стиль одежды", text: "Какие вещи ты ищешь?")
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
        PickerSeveralItems(data: WearStyle.allCases, rows: 3, selectedData: $viewModel.smartFormModel.wearStyle) { data in
            viewModel.smartFormModel.wearStyle = data
            checkAvailable()
        }
    }
    
    private func checkAvailable() {
        isValid = !viewModel.smartFormModel.wearStyle.isEmpty
    }
    
}
