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
    @State private var isShowTab: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $isShowTab) {
                    AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
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
                TopHeaderText(header: "Верх", text: "Дополнительные вопросы")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                SmartFormRouteManager.shared.push()
                return AnyView(SmartFormPantsScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerItems(data: WidthSizeType.allCases, header: "Воротники", rows: 2, selectedData: $viewModel.smartFormModel.shirt.colar) {
                    checkAvailable()
                }
                PickerItems(data: LengthSizeType.allCases, header: "Длина рукавов", rows: 2, selectedData: $viewModel.smartFormModel.shirt.sleeve) {
                    checkAvailable()
                }
                PickerItems(data: WidthSizeType.allCases, header: "В плечах", rows: 2, selectedData: $viewModel.smartFormModel.shirt.shoulders) {
                    checkAvailable()
                }
                PickerItems(data: WidthSizeType.allCases, header: "В талии", rows: 2, selectedData: $viewModel.smartFormModel.shirt.waist) {
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        let colar = viewModel.smartFormModel.shirt.colar != nil
        let shoulders = viewModel.smartFormModel.shirt.shoulders != nil
        let sleeve = viewModel.smartFormModel.shirt.sleeve != nil
        let waist = viewModel.smartFormModel.shirt.waist != nil
        isValid = colar && shoulders && sleeve && waist
    }
    
}
