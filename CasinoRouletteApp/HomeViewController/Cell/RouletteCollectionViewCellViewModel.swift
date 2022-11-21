//
//  RouletteCollectionViewCellViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 21.11.2022.
//

import Foundation

protocol RouletteCollectionViewCellViewModelProtocol {
    var rouletteTableCellNumber: String { get }
    init(rouletteTableCellNumber: String)
}

class RouletteCollectionViewCellViewModel: RouletteCollectionViewCellViewModelProtocol {
    var rouletteTableCellNumber: String
    
    required init(rouletteTableCellNumber: String) {
        self.rouletteTableCellNumber = rouletteTableCellNumber
    }
}
