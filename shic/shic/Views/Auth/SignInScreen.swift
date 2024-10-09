//
//  SignInScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isShowRegistration: Bool = false
    @State private var isShowVerification: Bool = false
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $isShowRegistration) {
                    RegistrationScreen()
                        .navigationBarHidden(true).environmentObject(viewModel)
                }
                .onChange(of: viewModel.userModel.phone) { _ in
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
        Text("Вход")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func text() -> some View {
        Text("Это же ты. Мы так по тебе скучали!")
            .font(Font.custom("Alegreya-Regular", size: 16))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func centerView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            FillField(type: .phone, text: $viewModel.userModel.phone, placeholder: "+7 999 999 99 99", name: "Телефон")
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
            Text("Нет аккаунта?")
                .font(Font.custom("Alegreya-Bold", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.darkPrimary)
            Button {
                isShowRegistration.toggle()
            } label: {
                Text("Создать")
                    .underline()
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.darkPrimary)
            }
        }
    }
    
    private func checkAvailable() {
        isValid = ValidManager.shared.checkPhoneNumber(viewModel.userModel.phone)
    }
    
}
