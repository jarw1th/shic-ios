//
//  SmartFormShirtScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormShirtScreen: View {
    
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
                TopHeaderText(header: "Футболки", text: "Дополнительные вопросы")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid)
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerItems(data: WidthSizeType.allCases, header: "Воротники", rows: 2, selectedData: $viewModel.smartFormModel.shirt.colar) { data in
                    viewModel.smartFormModel.shirt.colar = data
                    checkAvailable()
                }
                PickerItems(data: WidthSizeType.allCases, header: "В плечах", rows: 2, selectedData: $viewModel.smartFormModel.shirt.shoulders) { data in
                    viewModel.smartFormModel.shirt.shoulders = data
                    checkAvailable()
                }
                PickerItems(data: LengthSizeType.allCases, header: "Длина рукавов", rows: 2, selectedData: $viewModel.smartFormModel.shirt.sleeve) { data in
                    viewModel.smartFormModel.shirt.sleeve = data
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        let colar = viewModel.smartFormModel.shirt.colar != nil
        let shoulders = viewModel.smartFormModel.shirt.shoulders != nil
        let sleeve = viewModel.smartFormModel.shirt.sleeve != nil
        isValid = colar && shoulders && sleeve
    }
    
}
