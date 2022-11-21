//
//  HomeViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var rouletteCollectionView: UICollectionView!
    
    private var viewModel: HomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        rouletteCollectionView.register(UINib(nibName: "RouletteCollectionViewCell", bundle: nil),
                                        forCellWithReuseIdentifier: RouletteCollectionViewCell.identifier)
        checkForLogin()
        setupTabBar()
    }
    
    private func checkForLogin() {
        viewModel.checkForLogin { [weak self] loginVC in
            loginVC.modalPresentationStyle = .fullScreen
            self?.present(loginVC, animated: true)
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
            
        if cell?.backgroundColor == .red {
            cell?.backgroundColor = .clear
            viewModel.deleteBet(with: indexPath)
        } else {
            cell?.backgroundColor = .red
            viewModel.makeBet(with: indexPath)
        }
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
