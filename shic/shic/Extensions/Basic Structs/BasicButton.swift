//
//  Button.swift
//  shic
//
//  Created by Руслан Парастаев on 07.10.2024.
//

import SwiftUI

struct BasicButton: View {
    
    private var header: String? = nil
    private var title: String
    private var action: () -> Void
    
    private var isHigllited: Bool
    
    init(header: String? = nil, isHigllited: Bool = true, title: String, action: @escaping () -> Void) {
        self.header = header
        self.title = title
        self.action = action
        self.isHigllited = isHigllited
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let header {
                Text(header)
                    .font(.custom("Alegreya-Bold", size: 16))
                    .foregroundColor(Color.darkPrimary)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 20)
            }
            
            Button {
                action()
            } label: {
                Text(title)
                    .font(.custom("Alegreya-Bold", size: 16))
                    .foregroundColor(Color.darkPrimary)
                    .opacity(isHigllited ? 1.0 : 0.4)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.darkPrimary, lineWidth: 1.5)
                            .opacity(isHigllited ? 1.0 : 0.4)
                            .padding(1)
                    )
            }
        }
    }
    
}
