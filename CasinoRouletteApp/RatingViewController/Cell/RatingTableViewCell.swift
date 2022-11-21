//
//  RatingTableViewCell.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    static let identifier = "RatingCell"
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    
    var viewModel: RatingTableViewCellViewModelProtocol! {
        didSet {
            logoImage.image = UIImage(systemName: "person.fill")
            userNameLabel.text = viewModel.userName
            winRateLabel.text = viewModel.winRate?.description
            coinsLabel.text = viewModel.coins?.description
        }
    }
}
