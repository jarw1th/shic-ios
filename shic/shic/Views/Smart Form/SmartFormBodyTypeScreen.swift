//
//  SmartFormBodyTypeScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormBodyTypeScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValid: Bool = false
    
    @State private var bodyType: BodyType? = nil
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                RouteManager.shared.pop(false)
                presentationMode.wrappedValue.dismiss()
            }
            VStack(spacing: 40) {
                TopHeaderText(header: "Тип тела", text: "Укажи какая у тебя фигура")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        PickerMenuWithTip(data: BodyType.allCases, action: { data in
            bodyType = data
            if bodyType != nil {
                isValid = true
            }
        }, tip: { value in
            
        })
    }
    
}
