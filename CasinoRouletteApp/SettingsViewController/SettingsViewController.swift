//
//  SettingsViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func rateAppButtonPressed() {
        
    }
    
    @IBAction func shareButtonPressed() {
        let shareSheetVC = UIActivityViewController(
            activityItems: [URL(string: "https://www.apple.com")],
            applicationActivities: nil
        )
        present(shareSheetVC, animated: true)
    }
}
