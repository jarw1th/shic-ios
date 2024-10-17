//
//  HomeScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isShowNewOrder: Bool = false
    
    var body: some View {
        NavigationView() {
            makeContent()
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.isTabBarHidded = false
                    viewModel.fetchBanners()
                }
                .fullScreenCover(isPresented: $isShowNewOrder, onDismiss: {
                    viewModel.isTabBarHidded = false
                }) {
                    AnyView(AddressChooseScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
        }
        .endEditing()
    }
    
    private func makeContent() -> some View {
        VStack {
            centerView()
        }
        .padding(.horizontal, 20)
        .padding(.top, 70)
        .padding(.bottom, 20)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                Carousel(items: [viewModel.start])
                
                MainButton(text: "Сделать первый заказ") {
                    viewModel.newOrder()
                    isShowNewOrder.toggle()
                }
                
                ForEach(viewModel.promoBanner) { banner in
                    if viewModel.checkPromo(banner.promo) {
                        PromoBannerStruct(banner: banner) {
                            viewModel.newOrder()
                            viewModel.order.promo = banner.promo
                            viewModel.fetchDiscount()
                            isShowNewOrder.toggle()
                        }
                    }
                }
            }
        }
    }
    
}
