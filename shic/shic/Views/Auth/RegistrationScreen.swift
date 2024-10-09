//
//  RegistrationScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isShowSignIn: Bool = false
    @State private var isShowVerification: Bool = false
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView() {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $isShowSignIn) {
                    SignInScreen()
                        .navigationBarHidden(true).environmentObject(viewModel)
                }
                .onChange(of: viewModel.userModel.name) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.userModel.birthday) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.userModel.phone) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.userModel.isAccepted) { _ in
                    checkAvailable()
                }
                .onAppear {
                    checkAvailable()
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                header()
                text()
            }
            centerView()
            Spacer()
            buttons()
        }
        .padding(.horizontal, 20)
        .padding(.top, 140)
        .padding(.bottom, 70)
    }
    
    private func header() -> some View {
        Text("Создание аккаунта")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func text() -> some View {
        Text("Привет! Мы так рады тебя видеть :)")
            .font(Font.custom("Alegreya-Regular", size: 16))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func centerView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            FillField(text: $viewModel.userModel.name, placeholder: "Руслан", name: "Имя")
            FillField(type: .date, text: $viewModel.userModel.birthday, placeholder: "00.00.0000", name: "День рождения")
            FillField(type: .phone, text: $viewModel.userModel.phone, placeholder: "+7 999 999 99 99", name: "Телефон")
            AcceptField(isAccepted: $viewModel.userModel.isAccepted) {
                HStack {
                    Text("Согласен с")
                        .font(Font.custom("Alegreya-Regular", size: 12))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.darkPrimary)
                    Text("Условиями пользования.")
                        .underline()
                        .font(Font.custom("Alegreya-Regular", size: 12))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.darkPrimary)
                }
            }
        }
    }
    
    private func buttons() -> some View {
        VStack(spacing: 24) {
            largeButton()
            smallButton()
        }
    }
    
    private func largeButton() -> some View {
        MainButton(isAvailable: $isValid, text: "Отправить код") {
            if isValid {
                isShowVerification.toggle()
            }
        }
        .background {
            NavigationLink(
                destination: VerificationScreen()
                    .navigationBarHidden(true).environmentObject(viewModel)
                    .navigationBarHidden(true),
                isActive: $isShowVerification
            ) {
                EmptyView()
            }
        }
    }
    
    private func smallButton() -> some View {
        HStack(spacing: 24) {
            Text("Вы уже с нами?")
                .font(Font.custom("Alegreya-Bold", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.darkPrimary)
            Button {
                isShowSignIn.toggle()
            } label: {
                Text("Войти")
                    .underline()
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.darkPrimary)
            }
        }
    }
    
    private func checkAvailable() {
        let checkName = viewModel.userModel.name.count >= 2
        let checkDate = ValidManager.shared.checkDate(viewModel.userModel.birthday)
        let checkPhone = ValidManager.shared.checkPhoneNumber(viewModel.userModel.phone)
        
        isValid = checkName && checkDate && checkPhone && viewModel.userModel.isAccepted
    }
    
}
