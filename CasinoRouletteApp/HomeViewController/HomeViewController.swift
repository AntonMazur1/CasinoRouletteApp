//
//  HomeViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        checkForLogin()
        setupTabBar()
    }
    
    private func checkForLogin() {
        viewModel.checkForLogin { [weak self] loginVC in
            loginVC.modalPresentationStyle = .fullScreen
            self?.present(loginVC, animated: true)
        }
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.tintColor = .black
    }
}
