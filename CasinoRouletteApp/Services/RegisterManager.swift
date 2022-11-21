//
//  RegisterManager.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import FirebaseAuth

class RegisterManager {
    static let shared = RegisterManager()
    
    private init() {}
    
    func signUpUser(with login: String, and password: String, completion: @escaping() -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            guard error == nil else { return }
            completion()
        }
    }
}
