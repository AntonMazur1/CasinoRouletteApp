//
//  RouletteCollectionViewCell.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 21.11.2022.
//

import UIKit

class RouletteCollectionViewCell: UICollectionViewCell {
    static let identifier = "RouletteCell"
    
    @IBOutlet weak var rouletteTableCell: UILabel!
    
    var viewModel: RouletteCollectionViewCellViewModelProtocol! {
        didSet {
            rouletteTableCell.text = viewModel.rouletteTableCellNumber
        }
    }
    
}
