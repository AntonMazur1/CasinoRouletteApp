//
//  HomeViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    var numberOfItems: Int { get }
    func checkForLogin(completion: @escaping(LoginViewController) -> Void)
    func makeBet(with indexPath: IndexPath)
    func deleteBet(with indexPath: IndexPath)
    func getRouletteCollectionViewCellViewModel(at indexPath: IndexPath) -> RouletteCollectionViewCellViewModelProtocol?
}

class HomeViewModel: HomeViewModelProtocol {
    private var numbers: [String] = Array(0...31).map { String($0) }
    private var bets: [Int] = []
    
    var numberOfItems: Int {
        numbers.count
    }
    
    func checkForLogin(completion: @escaping(LoginViewController) -> Void) {
        AuthenticationManager.shared.checkForLogin() { loginVC in
            completion(loginVC)
        }
    }
    
    func makeBet(with indexPath: IndexPath) {
        guard let number = Int(numbers[indexPath.row]) else { return }
        bets.append(number)
    }
    
    func deleteBet(with indexPath: IndexPath) {
        let number = Int(numbers[indexPath.row])
        bets.removeAll(where: { $0 == number })
    }
    
    func getRouletteCollectionViewCellViewModel(at indexPath: IndexPath) -> RouletteCollectionViewCellViewModelProtocol? {
        RouletteCollectionViewCellViewModel(rouletteTableCellNumber: numbers[indexPath.row])
    }
}
