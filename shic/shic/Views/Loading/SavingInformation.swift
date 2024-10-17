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
    @State private var rotation: Double = 0
    
    var body: some View {
        makeContent()
            .onAppear {
                startRotationAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                    switch savingType {
                    case .smart:
                        viewModel.userModel.isSmartFormFill = true
                    case .style:
                        viewModel.userModel.isStyleFormFill = true
                    case .measure:
                        viewModel.userModel.isMeasureFormFill = true
                    }
                    viewModel.saveForm(savingType)
                    viewModel.saveUser()
                    isShowNext.toggle()
                }
            }
            .fullScreenCover(isPresented: $isShowNext) {
                switch savingType {
                case .smart:
                    if viewModel.userModel.isMeasureFormFill {
                        return AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                    } else {
                        return AnyView(StartMeasureFormScreen().navigationBarHidden(true).environmentObject(viewModel))
                    }
                case .style:
                    return AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                case .measure:
                    if viewModel.userModel.isStyleFormFill {
                        return AnyView(TabScreen().navigationBarHidden(true).environmentObject(viewModel))
                    } else {
                        return AnyView(StartStyleFormScreen().navigationBarHidden(true).environmentObject(viewModel))
                    }
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
                
                VStack(spacing: 24) {
                    Spacer()
                    Text("Загрузка...")
                        .font(Font.custom("Alegreya-Bold", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.darkPrimary)
                        .padding(.bottom, 52)
                }
                
                GeometryReader { geoHStack in
                    HStack(spacing: 16) {
                        Spacer()
                        ForEach(["s", "h", "i", "c"], id: \.self) { letter in
                            Text(letter)
                                .font(Font.custom("CroissantOne-Regular", size: 100))
                                .rotationEffect(Angle(degrees: rotation))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .foregroundStyle(.darkPrimary)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
    
    private func startRotationAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            rotation += 2.0
            if rotation >= 360 {
                rotation = 0
            }
        }
    }
    
}
