//
//  LoginViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import Foundation

protocol LoginViewModelProtocol {
    func signInUser(with login: String, and password: String)
    func signInWithGoogle(presentingVC: LoginViewController, completion: @escaping() -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    func signInUser(with login: String, and password: String) {
        AuthenticationManager.shared.signInUser(with: login, and: password)
    }
    
    func signInWithGoogle(presentingVC: LoginViewController, completion: @escaping() -> Void) {
        AuthenticationManager.shared.signInWithGoogle(presentingVC: presentingVC, completion: completion)
    }
}
