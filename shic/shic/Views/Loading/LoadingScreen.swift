//
//  LoadingScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct LoadingScreen: View {
    
    @StateObject private var viewModel: ViewModel = ViewModel()
    
    @State private var isShowAuth: Bool = false
    @State private var isShowTab: Bool = false
    
    var body: some View {
        makeContent()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                if UserDefaultsManager.shared.testLoginInfo.isEmpty {
                    isShowAuth.toggle()
                } else {
                    viewModel.userModel.uid = UserDefaultsManager.shared.testLoginInfo
                    viewModel.fetchUser()
                    isShowTab.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $isShowAuth) {
            StartAuthScreen()
                .navigationBarHidden(true).environmentObject(viewModel)
        }
        .fullScreenCover(isPresented: $isShowTab) {
            TabScreen()
                .navigationBarHidden(true).environmentObject(viewModel)
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
                    GeometryReader { geoHStack in
                        HStack {
                            ForEach(["s", "h", "i", "c"], id: \.self) { letter in
                                Text(letter)
                                    .font(Font.custom("CroissantOne-Regular", size: CGFloat.random(in: 40...100)))
                                    .rotationEffect(Angle(degrees: Double.random(in: -40...40)))
                                    .offset(y: CGFloat.random(in: 40...geoHStack.size.height - 40))
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .foregroundStyle(.darkPrimary)
                    }
                    .frame(maxHeight: .infinity)
                    Text(Constants.loadingPhrases.randomElement() ?? "Одевайся по-новому")
                        .font(Font.custom("Alegreya-Bold", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.darkPrimary)
                        .padding(.bottom, 52)
                }
            }
        }
    }
    
}
