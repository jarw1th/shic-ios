//
//  SmartFormBodyTypeScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormBodyTypeScreen: View {
    
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
                TopHeaderText(header: "Тип тела", text: "Укажи какая у тебя фигура")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, isImportant: true, nextAction: {
                    AnyView(SmartFormSpecificBodyScreen().navigationBarHidden(true).environmentObject(viewModel))
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        PickerMenuWithTip(data: BodyType.allCases, selectedData: $viewModel.smartFormModel.bodyType, action: { 
            checkAvailable()
        }, tip: { value in
            
        })
    }
    
    private func checkAvailable() {
        isValid = viewModel.smartFormModel.bodyType != nil
    }
    
}
