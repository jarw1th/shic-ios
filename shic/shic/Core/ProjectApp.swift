//
//  shicApp.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

@main
struct shicApp: App {
    
    var body: some Scene {
        WindowGroup {
            LoadingScreen()
                .preferredColorScheme(.light)
        }
    }
    
}
