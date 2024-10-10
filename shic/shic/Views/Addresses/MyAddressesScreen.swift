//
//  MyAddressesScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 09.10.2024.
//

import SwiftUI

struct MyAddressesScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var newScreen: AnyView?
    @State private var editScreen: AnyView?
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onAppear {
                    viewModel.fetchAddresses()
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Адреса", text: "Ваши сохраненные адреса")
                centerView()
            }
            MainButton(text: "Создать новый") {
                viewModel.newAddress()
                newScreen = AnyView(NewAddressScreen(isEdit: false).navigationBarHidden(true).environmentObject(viewModel))
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
                    BasicButton(header: address.name, title: "\(address.city), \(address.street), \(address.room)") {
                        viewModel.address = address
                        editScreen = AnyView(NewAddressScreen(isEdit: true).navigationBarHidden(true).environmentObject(viewModel))
                    }
                    .background {
                        NavigationLink(destination: editScreen, isActive: Binding(
                            get: { editScreen != nil },
                            set: { if !$0 { editScreen = nil } }
                        )) {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
    
}
