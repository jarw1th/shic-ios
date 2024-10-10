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
                TopHeaderText(header: "Обувь", text: "Дополнительные вопросы")
                centerView()
                Spacer()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                SmartFormRouteManager.shared.push()
                return AnyView(SmartFormWearTypeScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
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
