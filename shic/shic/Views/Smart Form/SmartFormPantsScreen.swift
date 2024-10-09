//
//  SmartFormPantsScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormPantsScreen: View {
    
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
                TopHeaderText(header: "Низ", text: "Дополнительные вопросы")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                AnyView(SmartFormFootScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerItems(data: PlantingType.allCases, header: "Посадка", rows: 2, selectedData: $viewModel.smartFormModel.pants.planting) {
                    checkAvailable()
                }
                PickerItems(data: WidthSizeType.allCases, header: "Ширина", rows: 2, selectedData: $viewModel.smartFormModel.pants.width) {
                    checkAvailable()
                }
                PickerItems(data: LengthSizeType.allCases, header: "Длина", rows: 2, selectedData: $viewModel.smartFormModel.pants.length) {
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        let planting = viewModel.smartFormModel.pants.planting != nil
        let width = viewModel.smartFormModel.pants.width != nil
        let length = viewModel.smartFormModel.pants.length != nil
        isValid = planting && width && length
    }
    
}
