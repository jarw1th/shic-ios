//
//  LoadingScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct LoadingScreen: View {
    
    @StateObject private var router = LoadingRouter()
    
    var body: some View {
        makeContent()
        .onAppear {
            let view = router.view()
            router.present(view, with: .fullScreen)
        }
        .fullScreenCover(item: $router.fullScreenView) { fullScreenView in
            fullScreenView.view
        }
    }
    
    private func makeContent() -> some View {
        ZStack {
            VStack {
                Circle()
                    .stroke(Color.darkPrimary, lineWidth: 1)
                    .opacity(0.4)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 100)
                Spacer()
            }
            VStack(alignment: .leading) {
                Spacer()
                Circle()
                    .stroke(Color.darkPrimary, lineWidth: 1)
                    .opacity(0.4)
                    .frame(width: 200, height: 200)
                    .padding(.top, 40)
                    .padding(.trailing, 40)
            }
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
