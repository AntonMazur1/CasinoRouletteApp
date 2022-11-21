//
//  RatingViewController.swift
//  CasinoRouletteApp
//
//  Created by Клоун on 17.11.2022.
//

import UIKit

class RatingViewController: UIViewController {
    @IBOutlet weak var ratingTableView: UITableView!
    
    private var viewModel: RatingViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RatingViewModel()
        ratingTableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil),
                                 forCellReuseIdentifier: RatingTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUsers { [weak self] in
            self?.ratingTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ratingTableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.identifier, for: indexPath) as! RatingTableViewCell
        cell.viewModel = viewModel.getRatingViewModel(at: indexPath)
        return cell
    }
}
