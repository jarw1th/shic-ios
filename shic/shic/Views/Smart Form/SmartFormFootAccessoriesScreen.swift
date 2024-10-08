//
//  SmartFormFootAccessoriesScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormFootAccessoriesScreen: View {
    
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
                TopHeaderText(header: "Обувь и акссесуары", text: "Выбери, что тебе нравится")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isImportant: true)
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerSeveralItems(data: FootType.allCases, header: "Обувь", rows: 2, selectedData: $viewModel.smartFormModel.foot.type) {
                    checkAvailable()
                }
                PickerSeveralItems(data: AccessoriesType.allCases, header: "Аксессуары", rows: 2, selectedData: $viewModel.smartFormModel.accessories) {
                    checkAvailable()
                }
                PickerSeveralItems(data: JewelryType.allCases, header: "Бижутерия", rows: 3, selectedData: $viewModel.smartFormModel.jewelry) {
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        let foot = !viewModel.smartFormModel.foot.type.isEmpty
        let accessories = !viewModel.smartFormModel.accessories.isEmpty
        let jewelry = !viewModel.smartFormModel.jewelry.isEmpty
        isValid = foot && accessories && jewelry
    }
    
}
