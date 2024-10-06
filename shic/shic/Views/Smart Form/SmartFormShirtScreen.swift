//
//  SmartFormShirtScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormShirtScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValid: Bool = false
    
    @State private var collar: WidthSizeType? = nil
    @State private var shoulder: WidthSizeType? = nil
    @State private var sleeve: LengthSizeType? = nil
    
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
                TopHeaderText(header: "Футболки", text: "Дополнительные вопросы")
                centerView()
                Spacer()
            }
            BottomBarForm(isAvailable: $isValid)
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerItems(data: WidthSizeType.allCases, text: "Воротники", rows: 2) { data in
                    collar = data
                    checkAvailable()
                }
                PickerItems(data: WidthSizeType.allCases, text: "В плечах", rows: 2) { data in
                    shoulder = data
                    checkAvailable()
                }
                PickerItems(data: LengthSizeType.allCases, text: "Длина рукавов", rows: 2) { data in
                    sleeve = data
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        isValid = collar != nil
    }
    
}
