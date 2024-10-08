//
//  SavingInformation.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct SavingInformation: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    var savingType: FormType
    
    @State private var isShowNext: Bool = false
    
    var body: some View {
        makeContent()
            .onAppear {
                switch savingType {
                case .smart:
                    viewModel.userModel.isSmartFormFill = true
                case .style:
                    viewModel.userModel.isStyleFormFill = true
                }
                viewModel.saveForm(savingType)
                viewModel.saveUser()
                isShowNext.toggle()
            }
            .fullScreenCover(isPresented: $isShowNext) {
                switch savingType {
                case .smart:
                    StyleFormRouteManager.shared.initial(viewModel)
                    let screen = StyleFormRouteManager.shared.getScreen()
                    return AnyView(screen)
                case .style:
                    return AnyView(StyleFormRouteManager.shared.getScreen())
                }
            }
    }
    
    private func makeContent() -> some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .stroke(Color.darkPrimary, lineWidth: 1)
                    .opacity(0.4)
                    .frame(width: 200, height: 200)
                    .position(x: geo.size.width / 2, y: 0)
                    .offset(y: -100)
                
                Circle()
                    .stroke(Color.darkPrimary, lineWidth: 1)
                    .opacity(0.4)
                    .frame(width: 200, height: 200)
                    .position(x: 0, y: geo.size.height)
                
                VStack(spacing: 16) {
                    Spacer()
                    Image("LargeShicLogotype")
                        .resizable()
                        .aspectRatio(1.6, contentMode: .fit)
                        .frame(width: 200)
                    Text("Загрузка...")
                        .font(Font.custom("Alegreya-Bold", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                    Spacer()
                }
            }
        }
    }
    
}