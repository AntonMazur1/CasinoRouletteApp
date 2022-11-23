//
//  HomeViewModel.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    var maximumBetValue: Double? { get }
    var numberOfItems: Int { get }
    func checkForLogin(completion: @escaping(LoginViewController) -> Void)
    func checkForWin(with number: Int, and betSum: Int)
    func getUser(completion: @escaping() -> ())
    func makeBet(with indexPath: IndexPath, and betSum: Int)
    func deleteBet(with indexPath: IndexPath, and betSum: Int)
    func getRouletteCollectionViewCellViewModel(at indexPath: IndexPath) -> RouletteCollectionViewCellViewModelProtocol?
}

class HomeViewModel: HomeViewModelProtocol {
    private var numbers: [String] = Array(0...31).map { String($0) }
    private var bets: [Int: Int] = [:]
    
    var maximumBetValue: Double?
    
    var numberOfItems: Int {
        numbers.count
    }
    
    func checkForLogin(completion: @escaping(LoginViewController) -> Void) {
        AuthenticationManager.shared.checkForLogin() { loginVC in
            completion(loginVC)
        }
    }
    
    func checkForWin(with number: Int, and betSum: Int) {
        if let winBet = bets[number] {
            AuthenticationManager.shared.updateCoinsBasedOnGameResult(with: winBet, isWin: true)
        } else {
            AuthenticationManager.shared.updateCoinsBasedOnGameResult(with: betSum, isWin: false)
        }
    }
    
    func getUser(completion: @escaping() -> ()) {
        AuthenticationManager.shared.getUserData { userModel in
            self.maximumBetValue = Double(userModel.first?.coins ?? 0)
            completion()
        }
    }
    
    func makeBet(with indexPath: IndexPath, and betSum: Int) {
        guard let number = Int(numbers[indexPath.row]) else { return }
        bets[number] = betSum
    }
    
    func deleteBet(with indexPath: IndexPath, and betSum: Int) {
        guard let number = Int(numbers[indexPath.row]) else { return }
        bets.removeValue(forKey: number)
    }
    
    func getRouletteCollectionViewCellViewModel(at indexPath: IndexPath) -> RouletteCollectionViewCellViewModelProtocol? {
        RouletteCollectionViewCellViewModel(rouletteTableCellNumber: numbers[indexPath.row])
    }
}
