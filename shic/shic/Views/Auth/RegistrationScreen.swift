//
//  RegistrationScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @State private var isShowSignIn: Bool = false
    @State private var isShowVerification: Bool = false
    
    @State private var isValid: Bool = false
    
    @State private var name: String = ""
    @State private var date: String = ""
    @State private var phone: String = ""
    @State private var isAccepted: Bool = false
    
    var body: some View {
        NavigationView() {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .fullScreenCover(isPresented: $isShowSignIn) {
                    SignInScreen()
                }
                .onChange(of: name) { _ in
                    checkAvailable()
                }
                .onChange(of: date) { _ in
                    checkAvailable()
                }
                .onChange(of: phone) { _ in
                    checkAvailable()
                }
                .onChange(of: isAccepted) { _ in
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
            FillField(text: $name, placeholder: "Руслан", name: "Имя")
            FillField(type: .date, text: $date, placeholder: "00.00.0000", name: "День рождения")
            FillField(type: .phone, text: $phone, placeholder: "+7 999 999 99 99", name: "Телефон")
            AcceptField(isAccepted: $isAccepted) {
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
        MainButton(disabling: true, isAvailable: $isValid, text: "Отправить код") {
            if isValid {
                isShowVerification.toggle()
            }
        }
        .background {
            NavigationLink(
                destination: VerificationScreen(number: phone)
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
        let checkName = name.count >= 2
        let checkDate = ValidManager.shared.checkDate(date)
        let checkPhone = ValidManager.shared.checkPhoneNumber(phone)
        
        isValid = checkName && checkDate && checkPhone && isAccepted
    }
    
}
