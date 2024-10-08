//
//  Placeholder.swift
//  shic
//
//  Created by Руслан Парастаев on 08.10.2024.
//

import SwiftUI

struct Placeholder: View {
    
    var body: some View {
        Image("NoDataImage")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}
