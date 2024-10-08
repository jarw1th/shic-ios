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
    private var isImportant: Bool
    
    init(isAvailable: Binding<Bool>, isImportant: Bool = false) {
        self._isAvailable = isAvailable
        self.isImportant = isImportant
    }
    
    var body: some View {
        VStack(spacing: 24) {
            MainButton(isAvailable: $isAvailable, text: "Дальше") {
                SmartFormRouteManager.shared.push()
                next = AnyView(SmartFormRouteManager.shared.getScreen())
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
                    isShowLater.toggle()
                } label: {
                    Text("Заполню потом")
                        .underline()
                        .font(Font.custom("Alegreya-Bold", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                }
                
                if !isImportant {
                    Button {
                        SmartFormRouteManager.shared.push()
                        skip = AnyView(SmartFormRouteManager.shared.getScreen())
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
        .fullScreenCover(isPresented: $isShowLater) {
            AnyView(SmartFormRouteManager.shared.getLaterScreen())
        }
    }
    
}
