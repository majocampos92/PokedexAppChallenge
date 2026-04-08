//
//  ViewController.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var header: UIView!
    
    var viewModel: HomeViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
        setupCollection()
        bindViewModel()

        viewModel.fetchPokemons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Setup viewcollection
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.setGridLayout(columns: 2)
        
        collectionView.backgroundColor = UIColor(named: "backgroundPrimary")

        collectionView.register(
            UINib(nibName: PokemonCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier
        )
    }
    
    // MARK: - Setup viewcollection
    private func setupHeader() {
        header.backgroundColor = UIColor(named: "backgroundPrimary")
        
        imageHeader.image = UIImage(named: "imageHeader")
        imageHeader.contentMode = .scaleAspectFit
        
        titleHeader.text = "Pokédex"
        titleHeader.font = UIFont(name: "Montserrat-Bold", size: 24)
        titleHeader.textColor = UIColor(named: "SecondaryBlue")
        
        let text = "¡Hola, bienvenido!"

        let attributed = NSMutableAttributedString(string: text)

        let mediumFont = UIFont(name: "Montserrat-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
        let boldFont = UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)

        attributed.setFont(mediumFont, for: "¡Hola,", in: text)
        attributed.setFont(boldFont, for: "bienvenido", in: text)
        attributed.setFont(mediumFont, for: "!", in: text)
        
        welcomeText.textColor = UIColor(named: "PrimaryBlue")

        welcomeText.attributedText = attributed
    }

    // MARK: - Binding
    private func bindViewModel() {

        viewModel.onDataUpdated = { [weak self] indexPaths in
            DispatchQueue.main.async {
                self?.collectionView.performBatchUpdates {
                    UIView.performWithoutAnimation {
                        self?.collectionView.insertItems(at: indexPaths)
                    }
                }
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell

        let pokemon = viewModel.pokemons[indexPath.row]
        let container = Injector.shared.container

        cell.imageService = container.resolve(ImageService.self)
        
        cell.configure(with: pokemon)
        
        return cell
    }
}

extension HomeViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        let threshold = collectionView.contentSize.height - scrollView.frame.size.height

        if position > threshold - 100 {
            viewModel.fetchPokemons()
        }
    }
}
