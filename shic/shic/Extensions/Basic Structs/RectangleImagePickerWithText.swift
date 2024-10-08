//
//  ColorImagePicker.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct RectangleImagePickerWithText: View {
    
    var data: [String: String]
    var type: ShapeType
    var rows: Int =  1
    var action: () -> Void
    
    @Binding private var selectedData: [String]
    
    init(data: [String: String], type: ShapeType = .color, rows: Int = 1, selectedData: Binding<[String]>, action: @escaping () -> Void) {
        self.data = data
        self.type = type
        self.rows = rows
        self.action = action
        self._selectedData = selectedData
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(0..<rows, id: \.self) { index in
                HStack(spacing: 16) {
                    buttonsList(rowIndex: index)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func buttonsList(rowIndex: Int) -> some View {
        let items = Array(data.enumerated())
        let itemsPerRow = (items.count + rows - 1) / rows
        let startIndex = rowIndex * itemsPerRow
        let endIndex = min(startIndex + itemsPerRow, items.count)
        
        guard startIndex < items.count else { return AnyView(EmptyView()) }
        
        let rowItems = Array(items[startIndex..<endIndex])
        
        return AnyView(ForEach(rowItems, id: \.element.key) { index, element in
            let key = element.key
            let value = element.value
            
            Button {
                if let idx = selectedData.firstIndex(where: { $0 as AnyObject === value as AnyObject }) {
                    selectedData.remove(at: idx)
                } else {
                    selectedData.append(value)
                }
                action()
            } label: {
                VStack(spacing: 8) {
                    if type == .color {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: value))
                            .frame(height: 60)
                            .frame(minWidth: 60)
                    }
                    if type == .image {
                        WebImage(url: URL(string: value), content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                                .frame(minWidth: 60)
                        }, placeholder: {
                            Placeholder()
                        })
                    }
                    
                    Text(key)
                        .font(Font.custom("Alegreya-Regular", size: 16))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.darkPrimary)
                        .opacity(selectedData.contains(where: { $0 as AnyObject === value as AnyObject }) ? 1.0 : 0.4)
                }
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.darkPrimary)
                        .opacity(selectedData.contains(where: { $0 as AnyObject === value as AnyObject }) ? 1.0 : 0.4)
                        .padding(1)
                }
            }
        })
    }
    
}

