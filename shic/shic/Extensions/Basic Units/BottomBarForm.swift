//
//  BottomBarForm.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct BottomBarForm: View {
    
    @Binding var isAvailable: Bool
    
    @State private var next: AnyView? = nil
    @State private var skip: AnyView? = nil
    @State private var isShowLater: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            MainButton(isAvailable: $isAvailable, text: "Дальше") {
                next = AnyView(RouteManager.shared.getScreen())
            }
            .background {
                NavigationLink(destination: next, isActive: Binding(
                    get: { next != nil },
                    set: { if !$0 { next = nil } }
                )) {
                    EmptyView()
                }
            }
            HStack(spacing: 24) {
                Button {
                    RouteManager.shared.push()
                    isShowLater.toggle()
                } label: {
                    Text("Заполню потом")
                        .underline()
                        .font(Font.custom("Alegreya-Bold", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                }
                Button {
                    RouteManager.shared.push()
                    skip = AnyView(RouteManager.shared.getScreen())
                } label: {
                    Text("Пропустить")
                        .underline()
                        .font(Font.custom("Alegreya-Bold", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                }
                .background {
                    NavigationLink(destination: skip, isActive: Binding(
                        get: { skip != nil },
                        set: { if !$0 { skip = nil } }
                    )) {
                        EmptyView()
                    }
                }
            }
        }
    }
    
}
