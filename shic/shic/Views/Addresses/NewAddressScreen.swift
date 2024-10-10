//
//  NewAddressScree.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI

struct NewAddressScreen: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    var isEdit: Bool = false
    
    @State private var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            makeContent()
                .ignoresSafeArea()
                .onChange(of: viewModel.address.name) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.address.city) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.address.street) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.address.room) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.address.intercom) { _ in
                    checkAvailable()
                }
                .onChange(of: viewModel.address.floor) { _ in
                    checkAvailable()
                }
                .onAppear {
                    checkAvailable()
                }
        }
    }
    
    private func makeContent() -> some View {
        VStack(spacing: 16) {
            NavigationBarBack {
                dismiss()
            }
            VStack(spacing: 64) {
                TopHeaderText(header: "Новый адрес")
                centerView()
            }
            VStack(spacing: 24) {
                MainButton(isAvailable: $isValid, text: isEdit ? "Изменить" : "Создать") {
                    viewModel.saveAddress()
                    dismiss()
                }
                if isEdit {
                    Button {
                        viewModel.removeAddress()
                        dismiss()
                    } label: {
                        Text("Удалить")
                            .underline()
                            .font(Font.custom("Alegreya-Bold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.darkPrimary)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 78)
        .padding(.bottom, 114)
    }
    
    private func centerView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 16) {
                FillField(text: $viewModel.address.name, placeholder: "Дом", name: "Название адреса")
                FillField(text: $viewModel.address.city, placeholder: "Москва", name: "Город")
                FillField(text: $viewModel.address.street, placeholder: "ул. Пушкинская, д. 5", name: "Улица")
                FillField(type: .number, text: $viewModel.address.room, placeholder: "512", name: "Квартира")
                FillField(text: $viewModel.address.intercom, placeholder: "д212", name: "Домофон")
                FillField(type: .number, text: $viewModel.address.floor, placeholder: "4", name: "Этаж")
            }
        }
    }
    
    private func checkAvailable() {
        let name = !viewModel.address.name.isEmpty
        let city = !viewModel.address.city.isEmpty
        let street = !viewModel.address.street.isEmpty
        let room = !viewModel.address.room.isEmpty
        let intercom = !viewModel.address.intercom.isEmpty
        let floor = !viewModel.address.floor.isEmpty
        isValid = name && city && street && room && intercom && floor
    }
    
}
