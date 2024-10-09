//
//  SmartFormJacketScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormJacketScreen: View {
    
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
                TopHeaderText(header: "Верхняя одежда", text: "Дополнительные вопросы")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                AnyView(SmartFormShirtScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerItems(data: PlantingType.allCases, header: "Посадка", rows: 2, selectedData: $viewModel.smartFormModel.jacket.planting) {
                    checkAvailable()
                }
                PickerItems(data: WidthSizeType.allCases, header: "Воротник", rows: 2, selectedData: $viewModel.smartFormModel.jacket.colar) {
                    checkAvailable()
                }
                PickerItems(data: LengthSizeType.allCases, header: "Длина рукавов", rows: 2, selectedData: $viewModel.smartFormModel.jacket.sleeve) {
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        let colar = viewModel.smartFormModel.jacket.colar != nil
        let planting = viewModel.smartFormModel.jacket.planting != nil
        let sleeve = viewModel.smartFormModel.jacket.sleeve != nil
        isValid = colar && planting && sleeve
    }
    
}
