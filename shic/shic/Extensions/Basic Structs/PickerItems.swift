//
//  PickerItems.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct PickerItems<Data: StringData>: View {
    
    var data: [Data]
    var header: String? = nil
    var text: String? = nil
    var rows: Int =  1
    var action: (Data) -> Void
    
    @State private var selectedData: Data? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header {
                Text(header)
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.darkPrimary)
                    .padding(.leading, 20)
            }
            
            if let text {
                Text(text)
                    .font(Font.custom("Alegreya-Regular", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.darkPrimary)
                    .padding(.leading, 20)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                ForEach(0..<self.rows, id: \.self) { index in
                    HStack(spacing: 16) {
                        buttonsList(index)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func buttonsList(_ rowIndex: Int) -> some View {
        let itemsPerRow = (data.count + rows - 1) / rows
        let startIndex = rowIndex * itemsPerRow
        let endIndex = min(startIndex + itemsPerRow, data.count)
        let rowItems = Array(data[startIndex..<endIndex])
        
        return ForEach(rowItems, id: \.self) { value in
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
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
                    .background {
                        RoundedCorners(corners: .allCorners, radius: 20)
                            .stroke(Color.darkPrimary)
                            .opacity(selectedData == value ? 1.0 : 0.4)
                    }
            }
        }
    }
    
}

