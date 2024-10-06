//
//  PickerMenuWithTip.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct PickerMenuWithTip<Data: StringData>: View {
    
    var data: [Data]
    var header: String? = nil
    var action: (Data) -> Void
    var tip: (Data) -> Void
    @State private var selectedData: Data? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let header {
                Text(header)
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.darkPrimary)
                    .padding(.leading, 20)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                buttonsList()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func buttonsList() -> some View {
        ForEach(data, id: \.self) { value in
            HStack(spacing: 16) {
                Button {
                    selectedData = value
                    action(value)
                } label: {
                    Text(value.text())
                        .font(Font.custom("Alegreya-Regular", size: 16))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                        .opacity(selectedData == value ? 1.0 : 0.4)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background {
                            RoundedCorners(corners: .allCorners, radius: 20)
                                .stroke(Color.darkPrimary)
                                .opacity(selectedData == value ? 1.0 : 0.4)
                        }
                }
                Button {
                    tip(value)
                } label: {
                    Text("Что это?")
                        .underline()
                        .font(Font.custom("Alegreya-Regular", size: 16))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.darkPrimary)
                        .opacity(selectedData == value ? 1.0 : 0.4)
                }
            }
        }
    }
    
}

