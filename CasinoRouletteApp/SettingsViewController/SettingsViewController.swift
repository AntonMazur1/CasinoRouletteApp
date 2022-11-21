//
//  SettingsViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    
    private var viewModel: SettingsViewModelProtocol! {
        didSet {
            viewModel.settingViewModelDidChange = { [weak self] viewModel in
                self?.userNameLabel.text = viewModel.userName
                self?.coinsLabel.text = viewModel.amountOfCoins
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserData()
    }
    
    @IBAction func rateAppButtonPressed() {
        viewModel.displayStoreKit()
    }
    
    @IBAction func shareButtonPressed() {
        let shareSheetVC = UIActivityViewController(
            activityItems: [URL(string: "https://www.apple.com")],
            applicationActivities: nil
        )
        present(shareSheetVC, animated: true)
    }
    
    @IBAction func deleteUserAccount() {
        viewModel.deleteUserAccount { [weak self] in
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self?.present(loginVC, animated: true)
        }
    }
}
