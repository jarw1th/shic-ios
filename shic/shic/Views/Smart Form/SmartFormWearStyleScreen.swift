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
                TopHeaderText(header: "Одежда", text: "Какие стиль и вид тебе больше по душе?")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, isImportant: true, nextAction: {
                AnyView(SmartFormClothScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerSeveralItems(data: WearStyle.allCases, header: "Стиль", rows: 3, selectedData: $viewModel.smartFormModel.wearStyle) {
                    checkAvailable()
                }
                PickerSeveralItems(data: WearType.allCases, header: "Вид", rows: 3, selectedData: $viewModel.smartFormModel.wearType) {
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        let style = !viewModel.smartFormModel.wearStyle.isEmpty
        let type = !viewModel.smartFormModel.wearType.isEmpty
        isValid = style && type
    }
    
}
