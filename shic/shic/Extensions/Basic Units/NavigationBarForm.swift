//
//  NavigationBarForm.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

struct NavigationBarForm: View {
    
    private var index: Int {
        switch form {
        case .smart:
            SmartFormRouteManager.shared.formIndex
        case .style:
            StyleFormRouteManager.shared.formIndex
        }
    }
    private var count: Int {
        switch form {
        case .smart:
            SmartFormRouteManager.shared.formScreens.count
        case .style:
            StyleFormRouteManager.shared.formScreens.count
        }
    }
    var form: FormType
    var action: () -> Void
    
    init(form: FormType = .smart, _ action: @escaping () -> Void) {
        self.form = form
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
            ZStack {
                Circle()
                    .stroke(Color.darkPrimary.opacity(0.4), lineWidth: 1)
                    .frame(width: 46, height: 46)
                
                Text("\(index + 1)/\(count)")
                    .font(Font.custom("Alegreya-Bold", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.darkPrimary)
            }
        }
    }
    
}
