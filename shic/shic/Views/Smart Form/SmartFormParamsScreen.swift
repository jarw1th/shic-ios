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
    @State private var isShowTab: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $isShowTab) {
                    AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
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
                BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, isImportant: true, nextAction: {
                    AnyView(SmartFormBodyTypeScreen().navigationBarHidden(true).environmentObject(viewModel))
                })
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
