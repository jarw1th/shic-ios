//
//  StartAuthRouter.swift
//  shic
//
//  Created by Руслан Парастаев on 04.10.2024.
//

import SwiftUI

class StartAuthRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheetView: ViewWrapper? = nil
    @Published var fullScreenView: ViewWrapper? = nil

    func navigate<T: Hashable>(to view: T) {
        path.append(view)
    }
    
    func present<V: View>(_ view: V, with type: NavigationType) {
        let wrap = ViewWrapper(view)
        switch type {
        case .sheet:
            sheetView = wrap
        case .fullScreen:
            fullScreenView = wrap
        }
    }
    
    @ViewBuilder func view(for route: StartAuthRoute) -> some View {
        switch route {
        case .register:
            LoadingScreen()
        case .signIn:
            LoadingScreen()
        }
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        sheetView = nil
    }
    
    func dismissFullScreen() {
        fullScreenView = nil
    }
    
}
