//
//  ViewWrapper.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

struct ViewWrapper: Identifiable {
    
    let id = UUID()
    let view: AnyView
    
    init<V: View>(_ view: V) {
        self.view = AnyView(view)
    }
    
}
