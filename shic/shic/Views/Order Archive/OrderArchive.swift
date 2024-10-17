//
//  OrderArchive.swift
//  shic
//
//  Created by Руслан Парастаев on 11.10.2024.
//

import SwiftUI

struct OrderArchive: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var orderScreen: AnyView?
    
    @State private var isShowNewOrder: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onAppear {
                    viewModel.isTabBarHidded = true
                    viewModel.fetchOrders()
                }
                .fullScreenCover(isPresented: $isShowNewOrder) {
                    AnyView(AddressChooseScreen().navigationBarHidden(true).environmentObject(viewModel))
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Архив заказов")
                centerView()
            }
            MainButton(text: "Сделать заказ") {
                viewModel.newAddress()
                isShowNewOrder.toggle()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 114)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.doneOrders) { order in
                    OrderItem(status: order.endDate, title: order.name, action: {
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
