//
//  Untitled.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct StartSmartFormScreen: View {
    
    @State private var form: AnyView? = nil
    @State private var isShowTab: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $isShowTab) {
                    AnyView(RouteManager.shared.getLaterScreen())
                }
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
         Image("SmartFormVector")
            .resizable()
            .aspectRatio(1.13, contentMode: .fit)
            .frame(maxHeight: .infinity)
    }
    
    private func header() -> some View {
        Text("Умная форма")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(.darkPrimary)
    }
    
    private func text() -> some View {
        Text("Сейчас будет небольшая форма,\nкоторая поможет нам подобрать для вас идеальный гардероб.")
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
        MainButton(text: "Начать") {
            RouteManager.shared.push(false)
            form = AnyView(RouteManager.shared.getScreen())
        }
        .background {
            NavigationLink(destination: form, isActive: Binding(
                get: { form != nil },
                set: { if !$0 { form = nil } }
            )) {
                EmptyView()
            }
        }
    }
    
    private func smallButton() -> some View {
        HStack(spacing: 24) {
            Button {
                isShowTab.toggle()
            } label: {
                Text("Потом")
                    .underline()
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.darkPrimary)
            }
        }
    }
    
}
