//
//  HomeViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    func checkForLogin(completion: @escaping(LoginViewController) -> Void)
}

class HomeViewModel: HomeViewModelProtocol {
    func checkForLogin(completion: @escaping(LoginViewController) -> Void) {
        AuthenticationManager.shared.checkForLogin() { loginVC in
            completion(loginVC)
        }
    }
}
