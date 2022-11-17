//
//  UserModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 16.11.2022.
//

import Foundation

struct UserModel {
    let username: String?
    let coins: Int?
    let winRate: Int?
    
    init(data: [String: Any]) {
        let username = data["username"] as? String
        let coins = data["coins"] as? Int
        let winRate = data["winRate"] as? Int
        
        self.username = username
        self.coins = coins
        self.winRate = winRate
    }
}
