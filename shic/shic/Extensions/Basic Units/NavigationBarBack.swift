//
//  NavigationBarBack.swift
//  shic
//
//  Created by Руслан Парастаев on 09.10.2024.
//

import SwiftUI

struct NavigationBarBack: View {
    
    var action: () -> Void
    
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                ZStack {
                    Circle()
                        .stroke(Color.darkPrimary.opacity(0.4), lineWidth: 1)
                        .frame(width: 46, height: 46)
                    
                    Image("BackArrow")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.darkPrimary)
                }
            }
            Spacer()
        }
    }
    
}
