//
//  RouteManager.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

final class RouteManager {
    
    static let shared = RouteManager()
    
    private(set) var formIndex: Int
    private var screenIndex: Int
    private(set) var formScreens: [any View]
    
    init() {
        self.formIndex = 0
        self.screenIndex = 0
        self.formScreens = [StartSmartFormScreen(), SmartFormGenderScreen(), SmartFormWearStyleScreen()]
    }
    
    func initial() {
        self.formIndex = 0
        self.screenIndex = 0
        self.formScreens = [StartSmartFormScreen(), SmartFormGenderScreen(), SmartFormWearStyleScreen()]
    }
    
    func pop(_ incrementIndex: Bool = true) {
        if incrementIndex {
            formIndex -= 1
        }
        screenIndex -= 1
    }
    
    func getScreen() -> any View {
        if formScreens.count > screenIndex {
            let screen = formScreens[screenIndex].navigationBarHidden(true)
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
