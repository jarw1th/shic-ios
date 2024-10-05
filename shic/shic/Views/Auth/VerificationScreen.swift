//
//  VerificationScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct VerificationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowForm: Bool = false
    
    var number: String
    
    @State private var countdown: Int? = nil
    @State private var timer: Timer?
    
    @State private var isValid: Bool = false
    @State private var code: String = ""
    
    var body: some View {
        makeContent()
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isShowForm) {
                AnyView(RouteManager.shared.getScreen())
            }
            .onChange(of: code) { _ in
                checkAvailable()
            }
            .onAppear {
                startCountdown()
            }
            .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                HStack {
                    backButton()
                    Spacer()
                }
                header()
                text()
            }
            centerView()
            Spacer()
            buttons()
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func header() -> some View {
        Text("Верификация")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func text() -> some View {
        Text("Мы отправили тебе код на телефон\n\(number)")
            .font(Font.custom("Alegreya-Regular", size: 16))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func centerView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            CodeField(text: $code, numberOfDigits: 4)
        }
    }
    
    private func buttons() -> some View {
        VStack(spacing: 24) {
            largeButton()
            smallButton()
        }
    }
    
    private func largeButton() -> some View {
        MainButton(isAvailable: $isValid, text: "Готово") {
            if isValid {
                isShowForm.toggle()
            }
        }
    }
    
    private func backButton() -> some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack {
                Circle()
                    .stroke(Color.darkPrimary.opacity(0.4), lineWidth: 1)
                    .frame(width: 46, height: 46)
                
                Image("BackArrow")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.darkPrimary)
            }
        }
    }
    
    private func smallButton() -> some View {
        HStack(spacing: 24) {
            Text("Не получили код?")
                .font(Font.custom("Alegreya-Bold", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.darkPrimary)
            Button {
                startCountdown()
            } label: {
                Text(countdownText())
                    .underline()
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.darkPrimary)
                    .opacity(countdown == nil ? 1.0 : 0.4)
            }
            .disabled(countdown != nil)
        }
    }
    
    private func startCountdown() {
        countdown = 60
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let currentCountdown = countdown, currentCountdown > 0 {
                countdown = currentCountdown - 1
            } else {
                timer?.invalidate()
                timer = nil
                countdown = nil
            }
        }
    }
    
    private func countdownText() -> String {
        if let countdown = countdown {
            return "\(countdown)c"
        } else {
            return "Еще раз"
        }
    }
    
    private func checkAvailable() {
        isValid = ValidManager.shared.checkCode(code, numbers: 4)
    }
    
}
