//
//  RegisterViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import Foundation

protocol RegisterViewModelProtocol {
    func signUpUser(with login: String, and password: String, completion: @escaping() -> Void)
}

class RegisterViewModel: RegisterViewModelProtocol {
    func signUpUser(with login: String, and password: String, completion: @escaping() -> Void) {
        RegisterManager.shared.signUpUser(with: login, and: password, completion: completion)
    }
}
