//
//  TabsWrapper.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct TabScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var tab: TabType = .home
    
    var body: some View {
        makeContent()
            .ignoresSafeArea()
    }
    
    private func makeContent() -> some View {
        ZStack(alignment: .bottom) {
            views()
            if !viewModel.isTabBarHidded {
                tabs()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
            }
        }
    }
    
    private func views() -> some View {
        switch tab {
        case .home:
            return AnyView(HomeScreen().navigationBarHidden(true).environmentObject(viewModel))
        case .orders:
            return AnyView(OrdersScreen().navigationBarHidden(true).environmentObject(viewModel))
        case .profile:
            return AnyView(ProfileScreen().navigationBarHidden(true).environmentObject(viewModel))
        }
    }
    
    private func tabs() -> some View {
        HStack(spacing: 64) {
            Button {
                tab = .home
            } label: {
                ZStack {
                    Circle()
                        .fill((tab == .home) ? .white : .clear)
                        .frame(width: 48, height: 48)
                    
                    Image("Home")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle((tab == .home) ? .darkPrimary : .white)
                        .frame(width: 24, height: 24)
                }
            }
            
            Button {
                tab = .orders
            } label: {
                ZStack {
                    Circle()
                        .fill((tab == .orders) ? .white : .clear)
                        .frame(width: 48, height: 48)
                    
                    Image("Orders")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle((tab == .orders) ? .darkPrimary : .white)
                        .frame(width: 24, height: 24)
                }
            }
            
            Button {
                tab = .profile
            } label: {
                ZStack {
                    Circle()
                        .fill((tab == .profile) ? .white : .clear)
                        .frame(width: 48, height: 48)
                    
                    Image("Profile")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle((tab == .profile) ? .darkPrimary : .white)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.darkPrimary)
        )
    }
    
}
