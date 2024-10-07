//
//  SeveralPickerItems.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct PickerSeveralItems<Data: StringData>: View {
    
    var data: [Data]
    var header: String? = nil
    var text: String? = nil
    var rows: Int =  1
    var action: ([Data]) -> Void
    
    @Binding private var selectedData: [Data]
    
    init(data: [Data], header: String? = nil, text: String? = nil, rows: Int = 1, selectedData: Binding<[Data]> = Binding.constant([]), action: @escaping ([Data]) -> Void) {
        self.data = data
        self.header = header
        self.text = text
        self.rows = rows
        self.action = action
        self._selectedData = selectedData
    }
    
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
                if selectedData.contains(value),
                   let index = selectedData.firstIndex(of: value) {
                    selectedData.remove(at: index)
                } else {
                    selectedData.append(value)
                }
                action(selectedData)
            } label: {
                Text(value.text())
                    .font(Font.custom("Alegreya-Regular", size: 16))
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.darkPrimary)
                    .opacity(selectedData.contains(value) ? 1.0 : 0.4)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background {
                        RoundedCorners(corners: .allCorners, radius: 20)
                            .stroke(Color.darkPrimary)
                            .opacity(selectedData.contains(value) ? 1.0 : 0.4)
                            .padding(1)
                    }
            }
        }
    }
    
}

