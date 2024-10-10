//
//  OrdersScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct OrdersScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var orderScreen: AnyView?
    
    var body: some View {
        NavigationView() {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .onAppear {
                    viewModel.isTabBarHidded = false
                    viewModel.fetchOrders()
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
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 70)
        .padding(.bottom, 40)
    }
    
    private func header() -> some View {
        Text("Мои заказы")
            .font(Font.custom("Alegreya-Bold", size: 24))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.darkPrimary)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.orders) { order in
                    OrderItem(status: order.status.text(), title: order.name, action: {
                        viewModel.order = order
                        viewModel.isTabBarHidded = true
                        orderScreen = AnyView(OrderScreen().navigationBarHidden(true).environmentObject(viewModel))
                    }, chat: {
                        
                    })
                    .background {
                        NavigationLink(destination: orderScreen, isActive: Binding(
                            get: { orderScreen != nil },
                            set: { if !$0 { orderScreen = nil } }
                        )) {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
    
}
