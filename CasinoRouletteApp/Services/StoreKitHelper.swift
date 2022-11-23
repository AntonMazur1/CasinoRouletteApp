//
//  StoreKitHelper.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import StoreKit

struct StoreKitHelper {
    static func displayStoreKit() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
