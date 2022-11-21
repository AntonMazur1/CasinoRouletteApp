//
//  RatingViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import Foundation

protocol RatingViewModelProtocol {
    var numberOfRows: Int { get }
    func getUsers(completion: @escaping() -> ())
    func getRatingViewModel(at indexPath: IndexPath) -> RatingTableViewCellViewModelProtocol?
}

class RatingViewModel: RatingViewModelProtocol {
    private var users: [UserModel] = []
    
    var numberOfRows: Int {
        users.count
    }
    
    func getUsers(completion: @escaping() -> ()) {
        AuthenticationManager.shared.getUserData { [weak self] userModels in
            self?.users = userModels
            completion()
        }
    }
    
    func getRatingViewModel(at indexPath: IndexPath) -> RatingTableViewCellViewModelProtocol? {
        let user = users[indexPath.row]
        return RatingTableViewCellViewModel(
            userName: user.username ?? "",
            winRate: user.winRate ?? 0,
            coins: user.coins ?? 0
        )
    }
}
