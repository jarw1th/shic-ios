//
//  StyleFormDislikeColorScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI

struct StyleFormDislikeColorScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
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
                StyleFormRouteManager.shared.pop()
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Мне НЕ нравится")
                centerView()
            }
            BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, nextAction: {
                StyleFormRouteManager.shared.push()
                return AnyView(StyleFormPatternScreen().navigationBarHidden(true).environmentObject(viewModel))
            })
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                RectangleImagePickerWithText(data: DataManager.shared.getColors(), rows: 4, selectedData: $viewModel.styleFormModel.dislikedColors) {
                    checkAvailable()
                }
            }
        }
    }
    
    private func checkAvailable() {
        isValid = !viewModel.styleFormModel.lovingColors.isEmpty
    }
    
}
