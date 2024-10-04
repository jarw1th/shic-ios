//
//  StartAuthScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct StartAuthScreen: View {
    
    @StateObject private var router = StartAuthRouter()
    
    var body: some View {
        makeContent()
            .edgesIgnoringSafeArea(.top)
            .fullScreenCover(item: $router.fullScreenView) { fullScreenView in
                fullScreenView.view
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
    }
    
    private func image() -> some View {
        Image("VectorPlaceholder")
            .resizable()
            .aspectRatio(1.37, contentMode: .fit)
            .frame(height: 330)
    }
    
    private func header() -> some View {
        Text("Встречайте своего личного стилиста")
            .font(.system(size: 24, weight: .bold))
            .multilineTextAlignment(.center)
            .foregroundStyle(.darkPrimary)
    }
    
    private func text() -> some View {
        Text("Просто расскажите о своих предпочтениях,\nи мы подберем для вас стиль.")
            .font(.system(size: 16, weight: .regular))
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
        Button {
            let view = router.view(for: .register)
            router.present(view, with: .fullScreen)
        } label: {
            Text("Начать")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.darkPrimary)
                }
        }
    }
    
    private func smallButton() -> some View {
        HStack(spacing: 24) {
            Text("Вы уже с нами?")
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.darkPrimary)
            Button {
                let view = router.view(for: .signIn)
                router.present(view, with: .fullScreen)
            } label: {
                Text("Войти")
                    .font(.system(size: 16, weight: .bold))
                    .multilineTextAlignment(.center)
                    .underline()
                    .foregroundStyle(.darkPrimary)
            }
        }
    }
    
}
