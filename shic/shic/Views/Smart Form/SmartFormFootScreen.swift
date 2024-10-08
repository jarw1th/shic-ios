//
//  SmartFormFootScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormFootScreen: View {
    
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
                TopHeaderText(header: "Обувь", text: "Дополнительные вопросы")
                centerView()
                Spacer()
            }
            BottomBarForm(isAvailable: $isValid)
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            PickerItems(data: PlantingType.allCases, header: "Посадка", rows: 2, selectedData: $viewModel.smartFormModel.foot.planting) {
                checkAvailable()
            }
        }
    }
    
    private func checkAvailable() {
        isValid = viewModel.smartFormModel.foot.planting != nil
    }
    
}
