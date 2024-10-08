//
//  SmartFormRouteManager.swift
//  shic
//
//  Created by Руслан Парастаев on 05.10.2024.
//

import SwiftUI

final class SmartFormRouteManager {
    
    static let shared = SmartFormRouteManager()
    
    private var viewModel: ViewModel? = nil
    
    private(set) var formIndex: Int
    private var screenIndex: Int
    private(set) var formScreens: [any View]
    private var allScreens: [any View]
    
    init() {
        self.formIndex = 0
        self.screenIndex = 0
        self.formScreens = [SmartFormGenderScreen(), SmartFormParamsScreen(), SmartFormBodyTypeScreen(), SmartFormSpecificBodyScreen(), SmartFormWearStyleScreen(),
                            SmartFormClothScreen(), SmartFormSizesScreen(), SmartFormJacketScreen(), SmartFormShirtScreen(), SmartFormPantsScreen(), SmartFormFootScreen(),
                            SmartFormWearTypeScreen(), SmartFormFootAccessoriesScreen(), SmartFormBudgetScreen()]
        self.allScreens = [StartSmartFormScreen(), SmartFormGenderScreen(), SmartFormParamsScreen(), SmartFormBodyTypeScreen(), SmartFormSpecificBodyScreen(),
                           SmartFormWearStyleScreen(), SmartFormClothScreen(), SmartFormSizesScreen(), SmartFormJacketScreen(), SmartFormShirtScreen(),
                           SmartFormPantsScreen(), SmartFormFootScreen(), SmartFormWearTypeScreen(), SmartFormFootAccessoriesScreen(), SmartFormBudgetScreen()]
    }
    
    func initial(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        self.formIndex = 0
        self.screenIndex = 0
        self.formScreens = [SmartFormGenderScreen(), SmartFormParamsScreen(), SmartFormBodyTypeScreen(), SmartFormSpecificBodyScreen(), SmartFormWearStyleScreen(),
                            SmartFormClothScreen(), SmartFormSizesScreen(), SmartFormJacketScreen(), SmartFormShirtScreen(), SmartFormPantsScreen(), SmartFormFootScreen(),
                            SmartFormWearTypeScreen(), SmartFormFootAccessoriesScreen(), SmartFormBudgetScreen()]
        self.allScreens = [StartSmartFormScreen(), SmartFormGenderScreen(), SmartFormParamsScreen(), SmartFormBodyTypeScreen(), SmartFormSpecificBodyScreen(),
                           SmartFormWearStyleScreen(), SmartFormClothScreen(), SmartFormSizesScreen(), SmartFormJacketScreen(), SmartFormShirtScreen(),
                           SmartFormPantsScreen(), SmartFormFootScreen(), SmartFormWearTypeScreen(), SmartFormFootAccessoriesScreen(), SmartFormBudgetScreen()]
    }
    
    func pop(_ decrementIndex: Bool = true) {
        if decrementIndex {
            formIndex -= 1
        }
        screenIndex -= 1
    }
    
    func getScreen() -> any View {
        if allScreens.count == screenIndex,
           let viewModel {
            let screen = SavingInformation(savingType: .smart).navigationBarHidden(true).environmentObject(viewModel)
            return screen
        } else if allScreens.count > screenIndex,
                  let viewModel {
                   let screen = allScreens[screenIndex].navigationBarHidden(true).environmentObject(viewModel)
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
        if let viewModel {
            let screen = TabScreen().navigationBarHidden(true).environmentObject(viewModel)
            return screen
        } else {
            return LoadingScreen()
        }
    }
    
}
