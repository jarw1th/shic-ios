//
//  SmartFormBudgetScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SmartFormBudgetScreen: View {
    
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
                TopHeaderText(header: "Бюджет", text: "Какой у тебя бюджет?")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                AnyView(SavingInformation(savingType: .smart).navigationBarHidden(true).environmentObject(viewModel))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                FillField(type: .budget, text: $viewModel.smartFormModel.jacket.price, placeholder: "До 2000 рублей", name: "Верхняя одежда")
                FillField(type: .budget, text: $viewModel.smartFormModel.shirt.price, placeholder: "До 4000 рублей", name: "Верх")
                FillField(type: .budget, text: $viewModel.smartFormModel.pants.price, placeholder: "До 3000 рублей", name: "Низ")
                FillField(type: .budget, text: $viewModel.smartFormModel.foot.price, placeholder: "До 12000 рублей", name: "Обувь")
            }
        }
    }
    
    private func checkAvailable() {
        let jacket = !viewModel.smartFormModel.jacket.price.isEmpty
        let shirt = !viewModel.smartFormModel.shirt.price.isEmpty
        let pants = !viewModel.smartFormModel.pants.price.isEmpty
        let foot = !viewModel.smartFormModel.foot.price.isEmpty
        isValid = jacket && shirt && pants && foot
    }
    
}
