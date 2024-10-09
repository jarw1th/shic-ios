//
//  SmartFormGender.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct SmartFormGenderScreen: View {
    
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
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Пол")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, isImportant: true, nextAction: {
                    AnyView(SmartFormParamsScreen().navigationBarHidden(true).environmentObject(viewModel))
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        PickerMenu(data: Gender.allCases, placeholder: "выбери", header: "Я ", selectedData: $viewModel.smartFormModel.gender) { 
            checkAvailable()
        }
    }
    
    private func checkAvailable() {
        isValid = viewModel.smartFormModel.gender != nil
    }
    
}
