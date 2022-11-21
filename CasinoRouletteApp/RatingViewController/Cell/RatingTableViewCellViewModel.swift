//
//  RatingTableViewCellViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import Foundation

protocol RatingTableViewCellViewModelProtocol {
    var userName: String? { get }
    var winRate: Int? { get }
    var coins: Int? { get }
    init(userName: String, winRate: Int, coins: Int)
}

class RatingTableViewCellViewModel: RatingTableViewCellViewModelProtocol {
    var userName: String?
    var winRate: Int?
    var coins: Int?
    
    required init(userName: String, winRate: Int, coins: Int) {
        self.userName = userName
        self.winRate = winRate
        self.coins = coins
    }
}
