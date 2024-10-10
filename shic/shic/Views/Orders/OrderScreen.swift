//
//  OrderScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI

struct OrderScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValid: Bool = false
    @State private var addressScreen: AnyView?
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: viewModel.order.name)
                centerView()
            }
            VStack(spacing: 24) {
                if viewModel.order.status != .waiting {
                    MainButton(isAvailable: $isValid, text: "Заказ") {
                        dismiss()
                    }
                }
                HStack(spacing: 24) {
                    Button {
                        viewModel.order.status = .canceled
                        viewModel.saveOrder()
                        dismiss()
                    } label: {
                        Text("Отменить заказ")
                            .underline()
                            .font(Font.custom("Alegreya-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.darkPrimary)
                    }
                    Button {
                        
                    } label: {
                        Text("Открыть чат")
                            .underline()
                            .font(Font.custom("Alegreya-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.darkPrimary)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 114)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                BasicButton(header: "Статус", title: viewModel.order.status.text(), action: {})
                    .disabled(true)
                BasicButton(header: "Адрес", title: "\(viewModel.order.address.city), \(viewModel.order.address.street), \(viewModel.order.address.room)", action: {
                    addressScreen = AnyView(NewAddressScreen(isEdit: true).navigationBarHidden(true).environmentObject(viewModel))
                })
                .background {
                    NavigationLink(destination: addressScreen, isActive: Binding(
                        get: { addressScreen != nil },
                        set: { if !$0 { addressScreen = nil } }
                    )) {
                        EmptyView()
                    }
                }
            }
        }
    }
    
}
