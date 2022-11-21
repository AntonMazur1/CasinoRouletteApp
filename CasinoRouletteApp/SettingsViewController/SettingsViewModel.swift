//
//  SettingsViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import Foundation

protocol SettingsViewModelProtocol {
    var userName: String? { get }
    var amountOfCoins: String? { get }
    var settingViewModelDidChange: ((SettingsViewModelProtocol) -> Void)? { get set }
    func displayStoreKit()
    func deleteUserAccount(completion: @escaping() -> Void)
    func getUserData()
}

class SettingsViewModel: SettingsViewModelProtocol {
    var userName: String?
    var amountOfCoins: String?
    
    var settingViewModelDidChange: ((SettingsViewModelProtocol) -> Void)?
    
    func displayStoreKit() {
        StoreKitHelper.displayStoreKit()
    }
    
    func deleteUserAccount(completion: @escaping () -> Void) {
        AuthenticationManager.shared.deleteUserAccount {
            completion()
        }
    }
    
    func getUserData() {
        AuthenticationManager.shared.getUserData { userModel in
            guard let userData = userModel.first else { return }
            self.userName = userData.username
            self.amountOfCoins = userData.coins?.description
            self.settingViewModelDidChange?(self)
        }
    }
}
