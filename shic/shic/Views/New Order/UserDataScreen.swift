//
//  UserDataScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct UserDataScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var newScreen: AnyView?
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onChange(of: viewModel.userModel.name) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.userModel.surname) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.userModel.phone) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.userModel.email) { _ in
                    checkAvailable()
                }
                .onAppear {
                    checkAvailable()
                }
                .onAppear {
                    viewModel.fetchUser()
                    checkAvailable()
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
                TopHeaderText(header: "Данные", text: "Заполни свои данные")
                centerView()
            }
            MainButton(isAvailable: $isValid, text: "Дальше") {
                newScreen = AnyView(PrepayScreen().navigationBarHidden(true).environmentObject(viewModel))
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
                FillField(text: $viewModel.userModel.name, placeholder: "Руслан", name: "Имя") { isValid in
                    if isValid {
                        viewModel.saveUser()
                    } else {
                        viewModel.fetchUser()
                    }
                }
                FillField(text: $viewModel.userModel.surname, placeholder: "Парастаев", name: "Фамилия") { isValid in
                    if isValid {
                        viewModel.saveUser()
                    } else {
                        viewModel.fetchUser()
                    }
                }
                FillField(type: .email, text: $viewModel.userModel.email, placeholder: "shic@gmail.com", name: "Почта") { isValid in
                    if isValid {
                        viewModel.saveUser()
                    } else {
                        viewModel.fetchUser()
                    }
                }
                FillField(type: .phone, text: $viewModel.userModel.phone, placeholder: "+7 999 999 99 99", name: "Телефон") { isValid in
                    if isValid {
                        viewModel.saveUser()
                    } else {
                        viewModel.fetchUser()
                    }
                }
                .disabled(true)
            }
        }
    }
    
    private func checkAvailable() {
        let name = viewModel.userModel.name.count >= 2
        let surname = viewModel.userModel.name.count >= 2
        let phone = ValidManager.shared.checkPhoneNumber(viewModel.userModel.phone)
        let email = ValidManager.shared.checkEmail(viewModel.userModel.email)
        
        isValid = name && surname && phone && email
    }
    
}
