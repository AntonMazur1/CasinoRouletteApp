//
//  HomeViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var rouletteCollectionView: UICollectionView!
    
    @IBOutlet weak var changeBetStepper: UIStepper!
    
    @IBOutlet weak var rolledNumberLabel: UILabel!
    @IBOutlet weak var betLabel: UILabel!
    
    private var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        rouletteCollectionView.register(UINib(nibName: "RouletteCollectionViewCell", bundle: nil),
                                        forCellWithReuseIdentifier: RouletteCollectionViewCell.identifier)
        checkForLogin()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUser {
            self.changeBetStepper.maximumValue = self.viewModel.maximumBetValue ?? 0
        }
    }
    
    @IBAction func changeBetStepper(_ sender: UIStepper) {
        betLabel.text = Int(sender.value).description
    }
    
    private func checkForLogin() {
        viewModel.checkForLogin { [weak self] loginVC in
            loginVC.modalPresentationStyle = .fullScreen
            self?.present(loginVC, animated: true)
        }
    }
    
    private func runTimer() {
        var timerLeft = 10
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            timerLeft -= 1
            
            self?.rolledNumberLabel.text = timerLeft.description
            self?.rouletteCollectionView.isUserInteractionEnabled = false
            
            if timerLeft == 0 {
                let winNumber = Int.random(in: 0...31)
                guard let betSum = Int(self?.betLabel.text ?? "") else { return }
                
                self?.rolledNumberLabel.text = winNumber.description
                self?.viewModel.checkForWin(with: winNumber, and: betSum)
                self?.rouletteCollectionView.isUserInteractionEnabled = true
                
                self?.viewModel.getUser {
                    self?.changeBetStepper.maximumValue = self?.viewModel.maximumBetValue ?? 0
                }
                
                timer.invalidate()
            }
        }
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.tintColor = .black
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = rouletteCollectionView.cellForItem(at: indexPath)
        
        guard let betSum = Int(betLabel.text ?? "") else { return }
        guard cell?.backgroundColor == .red else {
            cell?.backgroundColor = .red
            viewModel.makeBet(with: indexPath, and: betSum)
            runTimer()
            return
        }
        
        cell?.backgroundColor = .clear
        viewModel.deleteBet(with: indexPath, and: betSum)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = rouletteCollectionView.dequeueReusableCell(withReuseIdentifier: RouletteCollectionViewCell.identifier, for: indexPath) as! RouletteCollectionViewCell
        cell.viewModel = viewModel.getRouletteCollectionViewCellViewModel(at: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 8
        let paddingWidth = 10 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widhtPerItem = availableWidth / itemsPerRow
        return CGSize(width: widhtPerItem, height: widhtPerItem + widhtPerItem / 3)
    }
}
