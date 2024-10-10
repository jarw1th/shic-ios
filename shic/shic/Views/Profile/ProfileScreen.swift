//
//  ProfileScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isShowSmartForm: Bool = false
    @State private var isShowStyleForm: Bool = false
    @State private var isShowMeasureForm: Bool = false
    
    @State private var myAddresses: AnyView?
    
    var body: some View {
        NavigationView() {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $isShowSmartForm) {
                    AnyView(StartSmartFormScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
                .fullScreenCover(isPresented: $isShowStyleForm) {
                    AnyView(StartStyleFormScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
                .fullScreenCover(isPresented: $isShowMeasureForm) {
                    AnyView(StartMeasureFormScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
                .onAppear {
                    viewModel.isTabBarHidded = false
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                header()
            }
            centerView()
        }
        .padding(.horizontal, 20)
        .padding(.top, 70)
        .padding(.bottom, 40)
    }
    
    private func header() -> some View {
        Text("Профиль")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
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
                    FillField(type: .date, text: $viewModel.userModel.birthday, placeholder: "00.00.0000", name: "День рождения") { isValid in
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
                }
                VStack(alignment: .leading, spacing: 16) {
                    BasicButton(header: "Адреса", title: "Открыть") {
                        viewModel.isTabBarHidded = true
                        myAddresses = AnyView(MyAddressesScreen().navigationBarHidden(true).environmentObject(viewModel))
                    }
                    .background {
                        NavigationLink(destination: myAddresses, isActive: Binding(
                            get: { myAddresses != nil },
                            set: { if !$0 { myAddresses = nil } }
                        )) {
                            EmptyView()
                        }
                    }
                    BasicButton(header: "Архив заказов", title: "Открыть") {
                        
                    }
                    BasicButton(header: "Умная форма", title: viewModel.userModel.isSmartFormFill ? "Заполнить заново" : "Заполнить") {
                        isShowSmartForm.toggle()
                    }
                    BasicButton(header: "Замеры тела", title:  viewModel.userModel.isMeasureFormFill ? "Заполнить заново" : "Заполнить") {
                        isShowMeasureForm.toggle()
                    }
                    BasicButton(header: "Мой стиль", title: viewModel.userModel.isStyleFormFill ? "Заполнить заново" : "Заполнить") {
                        isShowSmartForm.toggle()
                    }
                }
                .padding(.bottom, 100)
            }
        }
    }
    
}
