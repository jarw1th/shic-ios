//
//  SmartFormSizesScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormSizesScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onChange(of: viewModel.smartFormModel.foot.sizes) { _ in
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
                TopHeaderText(header: "Размеры", text: "Прокрути вниз")
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
                VStack(alignment: .leading, spacing: 8) {
                    PickerSeveralItems(data: DefaultSizeTable.allCases, header: "Футболки", rows: 2, selectedData: $viewModel.smartFormModel.shirt.sizes) { data in
                        viewModel.smartFormModel.shirt.sizes = data
                        checkAvailable()
                    }
                    PickerItems(data: DefaultSizeType.allCases, text: "эти размеры мне", rows: 2, selectedData: $viewModel.smartFormModel.shirt.sizeType) { data in
                        viewModel.smartFormModel.shirt.sizeType = data
                        checkAvailable()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    PickerSeveralItems(data: DefaultSizeTable.allCases, header: "Штаны", rows: 2, selectedData: $viewModel.smartFormModel.pants.sizes) { data in
                        viewModel.smartFormModel.pants.sizes = data
                        checkAvailable()
                    }
                    PickerItems(data: DefaultSizeType.allCases, text: "эти размеры мне", rows: 2, selectedData: $viewModel.smartFormModel.pants.sizeType) { data in
                        viewModel.smartFormModel.pants.sizeType = data
                        checkAvailable()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    FillField(type: .footSize, text: $viewModel.smartFormModel.foot.sizes, placeholder: "40", name: "Обувь")
                    PickerItems(data: DefaultSizeType.allCases, text: "эти размеры мне", rows: 2, selectedData: $viewModel.smartFormModel.foot.sizeType) { data in
                        viewModel.smartFormModel.foot.sizeType = data
                        checkAvailable()
                    }
                }
            }
        }
    }
    
    private func checkAvailable() {
        let shirt = !viewModel.smartFormModel.shirt.sizes.isEmpty && viewModel.smartFormModel.shirt.sizeType != nil
        let pants = !viewModel.smartFormModel.pants.sizes.isEmpty && viewModel.smartFormModel.pants.sizeType != nil
        let foot = !viewModel.smartFormModel.foot.sizes.isEmpty && viewModel.smartFormModel.foot.sizeType != nil
        isValid = shirt && pants && foot
    }
    
}
