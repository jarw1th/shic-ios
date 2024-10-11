//
//  HomeScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView() {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.isTabBarHidded = false
                    viewModel.fetchBanners()
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                header()
            }
            centerView()
        }
        .padding(.horizontal, 20)
        .padding(.top, 70)
        .padding(.bottom, 40)
    }
    
    private func header() -> some View {
        Text("Приветствуем в Shic")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 32) {
                StartBannerStruct(banner: viewModel.start)
                
                ForEach(viewModel.promo) { banner in
                    PromoBannerStruct(banner: banner) {
                        viewModel.order.promo = banner.promo
                        viewModel.fetchDiscount()
                    }
                }
            }
        }
    }
    
}
