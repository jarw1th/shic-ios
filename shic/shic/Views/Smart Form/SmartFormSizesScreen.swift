//
//  SmartFormSizesScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormSizesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isValid: Bool = false
    
    @State private var shirtSizes: [DefaultSizeTable] = []
    @State private var shirtSizesType: DefaultSizeType? = nil
    @State private var pantsSizes: [DefaultSizeTable] = []
    @State private var pantsSizesType: DefaultSizeType? = nil
    @State private var footSizes: String = ""
    @State private var footSizesType: DefaultSizeType? = nil
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onChange(of: footSizes) { _ in
                    checkAvailable()
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                RouteManager.shared.pop(false)
                presentationMode.wrappedValue.dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Размеры", text: "Прокрути вниз")
                centerView()
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
                VStack(alignment: .leading, spacing: 8) {
                    PickerSeveralItems(data: DefaultSizeTable.allCases, header: "Футболки", rows: 2) { data in
                        shirtSizes = data
                        checkAvailable()
                    }
                    PickerItems(data: DefaultSizeType.allCases, text: "эти размеры мне", rows: 2) { data in
                        shirtSizesType = data
                        checkAvailable()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    PickerSeveralItems(data: DefaultSizeTable.allCases, header: "Штаны", rows: 2) { data in
                        pantsSizes = data
                        checkAvailable()
                    }
                    PickerItems(data: DefaultSizeType.allCases, text: "эти размеры мне", rows: 2) { data in
                        pantsSizesType = data
                        checkAvailable()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    FillField(type: .footSize, text: $footSizes, placeholder: "40", name: "Обувь")
                    PickerItems(data: DefaultSizeType.allCases, text: "эти размеры мне", rows: 2) { data in
                        footSizesType = data
                        checkAvailable()
                    }
                }
            }
        }
    }
    
    private func checkAvailable() {
        let shirt = !shirtSizes.isEmpty && shirtSizesType != nil
        let pants = !pantsSizes.isEmpty && pantsSizesType != nil
        let foot = !footSizes.isEmpty && footSizesType != nil
        isValid = shirt && pants && foot
    }
    
}
