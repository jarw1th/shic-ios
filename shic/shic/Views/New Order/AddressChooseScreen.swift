//
//  AddressChooseScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct AddressChooseScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var newScreen: AnyView?
    @State private var editScreen: AnyView?
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onAppear {
                    viewModel.fetchAddresses()
                    checkAvailable()
                    viewModel.isTabBarHidded = true
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Адрес", text: "Давай определимся с адресом доставки")
                centerView()
            }
            VStack(spacing: 24) {
                MainButton(isAvailable: $isValid, text: "Дальше") {
                    newScreen = AnyView(UserDataScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
                Button {
                    viewModel.newAddress()
                    newScreen = AnyView(NewAddressScreen(isEdit: false).navigationBarHidden(true).environmentObject(viewModel))
                } label: {
                    Text("Создать новый")
                        .underline()
                        .font(Font.custom("Alegreya-Bold", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                }
            }
            .background {
                NavigationLink(destination: newScreen, isActive: Binding(
                    get: { newScreen != nil },
                    set: { if !$0 { newScreen = nil } }
                )) {
                    EmptyView()
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
                ForEach(viewModel.addresses) { address in
                    BasicButton(header: address.name, isHigllited: address == viewModel.order.address, title: "\(address.city), \(address.street), \(address.room)") {
                        viewModel.order.address = address
                        checkAvailable()
                    }
                }
            }
        }
    }
    
    private func checkAvailable() {
        isValid = viewModel.order.address != nil
    }
    
}
