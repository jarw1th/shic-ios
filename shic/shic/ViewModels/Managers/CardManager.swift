//
//  CardManager.swift
//  shic
//
//  Created by Руслан Парастаев on 10.10.2024.
//

import SwiftUI
import TinkoffASDKCore
import TinkoffASDKUI

final class CardManager {
    
    static let shared = CardManager()
    
    private let credential: AcquiringSdkCredential
    private let coreSDKConfiguration: AcquiringSdkConfiguration
    private let uiSDKConfiguration = UISDKConfiguration()
    
    init() {
        self.credential = AcquiringSdkCredential(
            terminalKey: "TERMINAL_KEY",
            publicKey: "PUBLIC_KEY"
        )
        self.coreSDKConfiguration = AcquiringSdkConfiguration(
            credential: credential,
            server: .preProd
        )
        do {
            let sdk = try AcquiringUISDK(
                coreSDKConfiguration: coreSDKConfiguration,
                uiSDKConfiguration: uiSDKConfiguration
            )
        } catch {
            assertionFailure("\(error)")
        }
    }
    
}
