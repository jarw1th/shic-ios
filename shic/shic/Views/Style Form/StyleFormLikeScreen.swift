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
    @State private var isShowTab: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $isShowTab) {
                    AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
                .onAppear {
                    checkAvailable()
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarForm(form: .style) {
                if !(index == 0) {
                    StyleFormRouteManager.shared.pop()
                }
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Мне нравится...")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                AnyView(StyleFormColorScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
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
//        isValid = !viewModel.styleFormModel.lovingImages.isEmpty
        isValid = true
    }
    
}
