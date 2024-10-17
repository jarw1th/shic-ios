//
//  PrepayScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct PrepayScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValid: Bool = false
    @State private var isCompleted: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onAppear {
                    viewModel.fetchUser()
                    checkAvailable()
                }
                .fullScreenCover(isPresented: $isCompleted) {
                    AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Предоплата", text: "Внесите предоплату: \(viewModel.order.prepay)")
                centerView()
            }
            MainButton(isAvailable: $isValid, text: "Оплатить") {
                viewModel.saveNewOrder()
                isCompleted.toggle()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 114)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                FillField(text: $viewModel.order.promo, placeholder: "Shic", name: "Промокод") { isValid in
                    guard isValid else { return }
                    if self.isValid {
                        viewModel.order.discount = 0.0
                        viewModel.fetchDiscount()
                    } else {
                        viewModel.order.promo = ""
                        viewModel.order.discount = 0.0
                    }
                }
                Field(text: "\(Int(viewModel.order.discount * 100))%", name: "Скидка")
            }
        }
    }
    
    private func checkAvailable() {
        isValid = viewModel.checkPromo(viewModel.order.promo)
    }
    
}
