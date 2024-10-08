//
//  SmartFormWearTypeScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct SmartFormWearTypeScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onAppear {
                    checkAvailable()
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm {
                SmartFormRouteManager.shared.pop()
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Тип одежды", text: "Выбери, что тебе нравится")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isImportant: true)
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                PickerMenuWithTip(data: ShirtType.allCases, header: "Тип верхней одежды", selectedData: $viewModel.smartFormModel.jacket.type, action: {
                    checkAvailable()
                }, tip: { value in
                    
                })
                PickerMenuWithTip(data: ShirtType.allCases, header: "Тип верха", selectedData: $viewModel.smartFormModel.shirt.type, action: {
                    checkAvailable()
                }, tip: { value in
                    
                })
                PickerMenuWithTip(data: PantsType.allCases, header: "Тип низа", selectedData: $viewModel.smartFormModel.pants.type, action: {
                    checkAvailable()
                }, tip: { value in
                    
                })
            }
        }
    }
    
    private func checkAvailable() {
        let jacket = viewModel.smartFormModel.jacket.type != nil
        let shirt = viewModel.smartFormModel.shirt.type != nil
        let pants = viewModel.smartFormModel.pants.type != nil
        isValid = jacket && shirt && pants
    }
    
}
