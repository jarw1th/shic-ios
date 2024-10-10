//
//  MeasureFormScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 09.10.2024.
//

import SwiftUI

struct MeasureFormScreen: View {
    
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
                .onChange(of: viewModel.measureFormModel.bust) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.waist) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.hips) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.shoulderWidth) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.armLength) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.neck) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.inseamLength) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.measureFormModel.thigh) { _ in
                    checkAvailable()
                }
                .onAppear {
                    checkAvailable()
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Замеры", text: "Заполни поля со своими параметрами тела")
                centerView()
                Spacer()
                BottomBarForm(isAvailable: $isValid, isShowLater: $isShowTab, isImportant: true, nextAction: {
                    AnyView(SavingInformation(savingType: .measure).navigationBarHidden(true).environmentObject(viewModel))
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 70)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                FillField(type: .height, text: $viewModel.measureFormModel.bust, placeholder: "10 см", name: "Обхват груди")
                FillField(type: .height, text: $viewModel.measureFormModel.waist, placeholder: "20 см", name: "Обхват талии")
                FillField(type: .height, text: $viewModel.measureFormModel.hips, placeholder: "30 см", name: "Обхват бедер")
                FillField(type: .height, text: $viewModel.measureFormModel.shoulderWidth, placeholder: "40 см", name: "Ширина плеч")
                FillField(type: .height, text: $viewModel.measureFormModel.armLength, placeholder: "50 см", name: "Длина рук")
                FillField(type: .height, text: $viewModel.measureFormModel.neck, placeholder: "66 см", name: "Обхват шеи")
                FillField(type: .height, text: $viewModel.measureFormModel.inseamLength, placeholder: "70 см", name: "Длина ноги по внутренней поверхности")
                FillField(type: .height, text: $viewModel.measureFormModel.thigh, placeholder: "80 см", name: "Обхват бедра (верхняя часть)")
            }
        }
    }
    
    private func checkAvailable() {
        let bust = !viewModel.measureFormModel.bust.isEmpty
        let waist = !viewModel.measureFormModel.waist.isEmpty
        let hips = !viewModel.measureFormModel.hips.isEmpty
        let shoulders = !viewModel.measureFormModel.shoulderWidth.isEmpty
        let arm = !viewModel.measureFormModel.armLength.isEmpty
        let neck = !viewModel.measureFormModel.neck.isEmpty
        let inseam = !viewModel.measureFormModel.inseamLength.isEmpty
        let thigh = !viewModel.measureFormModel.thigh.isEmpty
        isValid = bust || waist || hips || shoulders || arm || neck || inseam || thigh
    }
    
}
