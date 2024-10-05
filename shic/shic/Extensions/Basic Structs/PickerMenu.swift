//
//  PickerMenu.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct PickerMenu<Data: StringData>: View {
    
    var data: [Data]
    var placeholder: String
    var header: String
    var action: (Data) -> Void
    @State private var isOpened: Bool = false
    @State private var selectedData: Data? = nil
    
    @State private var mainButtonWidth: CGFloat = 0
    @State private var headerWidth: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            mainButton()
            if isOpened {
                buttonsList()
            }
        }
    }
    
    private func mainButton() -> some View {
        Button {
            isOpened.toggle()
        } label: {
            HStack(spacing: 20) {
                Text(header)
                    .font(Font.custom("Alegreya-Regular", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.darkPrimary)
                    .background(GeometryReader { textGeometry in
                        Color.clear
                            .onAppear {
                                headerWidth = textGeometry.size.width
                            }
                    })
                Text(selectedData != nil ? (selectedData?.text() ?? "") : placeholder)
                    .font(Font.custom("Alegreya-Regular", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.darkPrimary)
                    .opacity(selectedData != nil ? 1.0 : 0.4)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.darkPrimary)
                    .opacity(selectedData != nil ? 1.0 : 0.4)
            }
        }
        .background(GeometryReader { hStackGeometry in
            Color.clear
                .onAppear {
                    mainButtonWidth = hStackGeometry.size.width
                }
        })
    }
    
    private func buttonsList() -> some View {
        ForEach(data, id: \.self) { value in
            Button {
                selectedData = value
                action(value)
                isOpened.toggle()
            } label: {
                Text(value.text())
                    .font(Font.custom("Alegreya-Regular", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.darkPrimary)
                    .opacity(selectedData == value ? 1.0 : 0.4)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
                    .frame(width: (mainButtonWidth - headerWidth) - 30, alignment: .leading)
                    .background {
                        RoundedCorners(corners: [.topRight, .bottomRight], radius: 20)
                            .stroke(Color.darkPrimary)
                            .opacity(selectedData == value ? 1.0 : 0.4)
                    }
            }
        }
    }
    
}
