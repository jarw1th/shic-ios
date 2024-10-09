//
//  BottomBarForm.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct BottomBarForm: View {
    
    @Binding var isAvailable: Bool
    @Binding var isShowLater: Bool
    @State var next: AnyView?
    var nextAction: () -> AnyView
    
    private var isImportant: Bool
    
    init(isAvailable: Binding<Bool>, isShowLater: Binding<Bool>, isImportant: Bool = false, nextAction: @escaping () -> AnyView) {
        self._isAvailable = isAvailable
        self._isShowLater = isShowLater
        self.isImportant = isImportant
        self.nextAction = nextAction
    }
    
    var body: some View {
        VStack(spacing: 24) {
            MainButton(isAvailable: $isAvailable, text: "Дальше") {
                SmartFormRouteManager.shared.push()
                next = nextAction()
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
                        next = nextAction()
                    } label: {
                        Text("Пропустить")
                            .underline()
                            .font(Font.custom("Alegreya-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.darkPrimary)
                    }
                }
            }
        }
    }
    
}
