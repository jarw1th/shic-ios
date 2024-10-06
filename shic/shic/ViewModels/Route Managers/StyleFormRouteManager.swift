//
//  StyleFormRouteManager.swift
//  shic
//
//  Created by Руслан Парастаев on 06.10.2024.
//

import SwiftUI

final class StyleFormRouteManager {
    
    static let shared = StyleFormRouteManager()
    
    private(set) var formIndex: Int
    private var screenIndex: Int
    private(set) var formScreens: [any View]
    private var allScreens: [any View]
    
    init() {
        self.formIndex = 0
        self.screenIndex = 0
        self.formScreens = []
        self.allScreens = []
    }
    
    func initial() {
        self.formIndex = 0
        self.screenIndex = 0
        self.formScreens = []
        self.allScreens = []
    }
    
    func pop(_ decrementIndex: Bool = true) {
        if decrementIndex {
            formIndex -= 1
        }
        screenIndex -= 1
    }
    
    func getScreen() -> any View {
        if allScreens.count > screenIndex {
            let screen = allScreens[screenIndex].navigationBarHidden(true)
            return screen
        } else {
            return getLaterScreen()
        }
    }
    
    func push(_ incrementIndex: Bool = true) {
        if incrementIndex {
            formIndex += 1
        }
        screenIndex += 1
    }
    
    func getLaterScreen() -> any View {
        let screen = LoadingScreen()
        return screen
    }
    
}
