//
//  ViewController.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomeViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollection()
        bindViewModel()

        viewModel.fetchPokemons()
    }

    // MARK: - Setup
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            UINib(nibName: PokemonCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier
        )
    }

    // MARK: - Binding
    private func bindViewModel() {

        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }

        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.showError(message)
            }
        }
    }

    // MARK: - Error UI
    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonCollectionViewCell.identifier,
            for: indexPath
        ) as! PokemonCollectionViewCell

        let pokemon = viewModel.pokemons[indexPath.row]

        cell.configure(with: pokemon)

        return cell
    }
}
