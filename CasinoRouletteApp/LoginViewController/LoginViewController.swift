//
//  LoginViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var googleSignInButton: UIButton!
    
    private var viewModel: LoginViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        setupTextFields(loginTextField, passwordTextField)
        googleSignInButton.clipsToBounds = true
        googleSignInButton.layer.cornerRadius = 30
    }
    
    @IBAction func loginButtonPressed() {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        
        viewModel.signInUser(with: login, and: password)
    }
    
    @IBAction func googleLoginButtonPressed() {
        viewModel.signInWithGoogle(presentingVC: self) {
            self.openMainViewController()
        }
    }
    
    private func setupTextFields(_ textFields: UITextField...) {
        textFields.forEach {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0,
                                      y: $0.frame.height - 3,
                                      width: $0.frame.width,
                                      height: 2)
            bottomLine.backgroundColor = UIColor.white.cgColor
            $0.layer.addSublayer(bottomLine)
        }
    }
    
    private func openMainViewController() {
        dismiss(animated: false)
    }
}

