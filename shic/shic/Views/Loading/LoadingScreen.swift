//
//  LoadingScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct LoadingScreen: View {
    
    @State private var isShowAuth: Bool = false
    
    var body: some View {
        makeContent()
        .onAppear {
            isShowAuth.toggle()
        }
        .fullScreenCover(isPresented: $isShowAuth) {
            StartAuthScreen()
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
                
                VStack {
                    Spacer()
                    Image("LargeShicLogotype")
                        .resizable()
                        .aspectRatio(1.6, contentMode: .fit)
                        .frame(width: 200)
                    Spacer()
                }
            }
        }
    }
    
}
