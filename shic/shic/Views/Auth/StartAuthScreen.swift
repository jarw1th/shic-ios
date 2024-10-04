//
//  StartAuthScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct StartAuthScreen: View {
    
    @State private var isShowSignIn: Bool = false
    @State private var isShowRegistration: Bool = false
    
    var body: some View {
        makeContent()
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $isShowRegistration) {
                RegistrationScreen()
            }
            .fullScreenCover(isPresented: $isShowSignIn) {
                SignInScreen()
            }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 32) {
            image()
            VStack(spacing: 24) {
                header()
                    .padding(.horizontal, 20)
                text()
                    .padding(.horizontal, 20)
            }
            buttons()
                .padding(.horizontal, 20)
        }
        .padding(.top, 70)
        .padding(.bottom, 70)
    }
    
    private func image() -> some View {
         Image("VectorPlaceholder")
            .resizable()
            .aspectRatio(1.13, contentMode: .fit)
            .frame(maxHeight: .infinity)
    }
    
    private func header() -> some View {
        Text("Встречайте своего личного стилиста")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(.darkPrimary)
    }
    
    private func text() -> some View {
        Text("Просто расскажите о своих предпочтениях,\nи мы подберем для вас стиль.")
            .font(Font.custom("Alegreya-Regular", size: 16))
            .multilineTextAlignment(.center)
            .foregroundStyle(.darkPrimary)
    }
    
    private func buttons() -> some View {
        VStack(spacing: 24) {
            largeButton()
            smallButton()
        }
    }
    
    private func largeButton() -> some View {
        MainButton(isAvailable: Binding.constant(true), text: "Начать") {
            isShowRegistration.toggle()
        }
    }
    
    private func smallButton() -> some View {
        HStack(spacing: 24) {
            Text("Вы уже с нами?")
                .font(Font.custom("Alegreya-Bold", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.darkPrimary)
            Button {
                isShowSignIn.toggle()
            } label: {
                Text("Войти")
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .underline()
                    .foregroundStyle(.darkPrimary)
            }
        }
    }
    
}
