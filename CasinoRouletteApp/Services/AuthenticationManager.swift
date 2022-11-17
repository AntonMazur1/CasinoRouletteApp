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
    
    func signInUser(with login: String, and password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { [weak self] result, error in
            guard error == nil else { return }
            self?.saveInDataBase()
            print("Success")
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
                
            self?.saveInDataBase()
            
            guard let auth = user?.authentication,
                  let idToken = auth.idToken
            else { return }
            
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: auth.accessToken)
            
            Auth.auth().signIn(with: credentials) { result, error in
                guard error == nil else { return }
                completion()
                print("Successfully")
            }
        }
    }
    
    func saveInDataBase(completion: (() -> Void)? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userData = ["username": userProfile?.username,
                        "coins": userProfile?.coins,
                        "winRate": userProfile?.winRate] as [String : Any]
        let values = [uid: userData]
        
        Database.database().reference().child("Users").updateChildValues(values) { error, _ in
            guard error == nil else { return }
            
            completion?()
            print("saved")
        }
    }
    
    func checkForLogin(completion: @escaping (LoginViewController) -> Void) {
        #warning("Сделать == вместо !=")
        guard Auth.auth().currentUser == nil else { return }
        
        DispatchQueue.main.async {
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            completion(loginVC)
        }
    }
}
