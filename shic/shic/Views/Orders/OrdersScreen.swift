//
//  OrdersScreen.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct OrdersScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView() {
            makeContent()
                .ignoresSafeArea()
                .navigationBarHidden(true)
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
        VStack(spacing: 16) {
            OrderItem(status: "В процессе", title: "Заказ #1020", action: {
                
            }, chat: {
                
            })
            OrderItem(status: "Нужно уточнить ", title: "Заказ #1024", action: {
                
            }, chat: {
                
            })
        }
    }
    
}
