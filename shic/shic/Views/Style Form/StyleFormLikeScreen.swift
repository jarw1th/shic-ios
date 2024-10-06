//
//  StyleFormLikeScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct StyleFormLikeScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    var index: Int
    
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
            NavigationBarForm(form: .style) {
                SmartFormRouteManager.shared.pop(!(index == 0))
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Мне нравится...")
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
                if viewModel.imagePacks.count > index {
                    RectangleImagePicker(data: viewModel.imagePacks[index], selectedData: $viewModel.styleFormModel.lovingImages) {
                        checkAvailable()
                    }
                }
            }
        }
    }
    
    private func checkAvailable() {
        let shirt = viewModel.smartFormModel.shirt.type != nil
        let pants = viewModel.smartFormModel.pants.type != nil
        isValid = shirt && pants
    }
    
}
