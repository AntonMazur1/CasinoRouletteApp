//
//  AuthenticationManager.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import GoogleSignIn

#warning("Убрать принты")

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private var userProfile: UserModel?
    
    private init() {}
    
    func signInUser(with login: String, and password: String, completion: @escaping() -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login,
                                        password: password) { [weak self] result, error in
            guard error == nil else { return }
            let userData = ["username": login, "coins": 2000, "winRate": 0]
            self?.saveInDataBase(userData: userData)
            completion()
        }
    }
    
    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping() -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingVC) { [weak self] user, error in
            guard error == nil else { return }
            guard let username = user?.profile?.name,
                  let userEmail = user?.profile?.email
            else { return }
            
            let userData = ["username": username, "coins": 2000, "winRate": 0]
            self?.userProfile = UserModel(data: userData)
            
            guard let auth = user?.authentication,
                  let idToken = auth.idToken
            else { return }
            
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: auth.accessToken)
            
            Auth.auth().signIn(with: credentials) { result, error in
                guard error == nil else { return }
                self?.saveInDataBase(userData: userData)
                completion()
            }
        }
    }
    
    func saveInDataBase(userData: [String : Any], completion: (() -> Void)? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = [uid: userData]
        
        Database.database().reference().child("Users").updateChildValues(values) { error, _ in
            guard error == nil else { return }
            print("saved")
            completion?()
        }
    }
    
    func checkForLogin(completion: @escaping (LoginViewController) -> Void) {
        guard Auth.auth().currentUser == nil else { return }
        DispatchQueue.main.async {
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            completion(loginVC)
        }
    }
    
    func getUserData(completion: @escaping([UserModel]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        ref.child("Users/\(uid)").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            let username = value["username"] as? String ?? ""
            let winRate = value["winRate"] as? Int ?? 0
            let coins = value["coins"] as? Int ?? 0
            
            completion([UserModel(data: ["username": username, "winRate": winRate, "coins": coins])])
        }
    }
    
    func deleteUserAccount(completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Users").child(uid).removeValue { [weak self] error, _ in
            guard error == nil else { return }
            try? Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            completion()
        }
    }
}
