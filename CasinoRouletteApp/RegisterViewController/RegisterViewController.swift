//
//  RegisterViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    private var viewModel: RegisterViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel()
        setupTextFields(loginTextField, passwordTextField)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        
        viewModel.signUpUser(with: login, and: password)
    }
    
    private func setupTextFields(_ textFields: UITextField...) {
        textFields.forEach {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0,
                                      y: $0.frame.height - 3,
                                      width: $0.frame.width,
                                      height: 3)
            bottomLine.backgroundColor = UIColor.white.cgColor
            $0.layer.addSublayer(bottomLine)
        }
    }
}
