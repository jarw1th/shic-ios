//
//  SmartFormWearStyleScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct SmartFormWearStyleScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValid: Bool = false
    
    @State private var styles: [WearStyle] = []
    
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
            VStack(spacing: 64) {
                TopHeaderText(header: "Стиль одежды", text: "Какие вещи ты ищешь?")
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
        PickerSeveralItems(data: WearStyle.allCases, rows: 2) { data in
            styles = data
            isValid = !styles.isEmpty
        }
    }
    
}
