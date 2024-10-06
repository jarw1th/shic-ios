//
//  ImagePicker.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

struct RectangleImagePicker: View {
    
    var data: [Image]
    var action: () -> Void
    
    @Binding private var selectedData: [Image]
    
    init(data: [Image], selectedData: Binding<[Image]> = Binding.constant([]), action: @escaping () -> Void) {
        self.data = Array(data.prefix(4))
        self.action = action
        self._selectedData = selectedData
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                if data.count > 0 {
                    button(data[0])
                } else {
                    placeholder()
                }
                if data.count > 1 {
                    button(data[1])
                } else {
                    placeholder()
                }
            }
            HStack(spacing: 16) {
                if data.count > 2 {
                    button(data[2])
                } else {
                    placeholder()
                }
                if data.count > 3 {
                    button(data[3])
                } else {
                    placeholder()
                }
            }
        }
    }
    
    private func button(_ value: Image) -> some View {
        Button {
            if selectedData.contains(value),
               let index = selectedData.firstIndex(of: value) {
                selectedData.remove(at: index)
            } else {
                selectedData.append(value)
            }
            action()
        } label: {
            value
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.darkPrimary)
                        .opacity(selectedData.contains(value) ? 1.0 : 0.4)
                )
        }
    }
    
    private func placeholder() -> some View {
        Button {
            
        } label: {
            Image("NoDataImage")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(20)
        }
    }
    
}

