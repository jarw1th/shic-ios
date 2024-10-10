//
//  SmartFormClothScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormClothScreen: View {
    
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
            VStack(spacing: 40) {
                TopHeaderText(header: "Ткань", text: "Какую ткань ты предпочитаешь?")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                    SmartFormRouteManager.shared.push()
                    return AnyView(SmartFormSizesScreen().navigationBarHidden(true).environmentObject(viewModel))
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        PickerSeveralItems(data: ClothType.allCases, rows: 2, selectedData: $viewModel.smartFormModel.clothType) {
            checkAvailable()
        }
    }
    
    private func checkAvailable() {
        isValid = !viewModel.smartFormModel.clothType.isEmpty
    }
    
}
