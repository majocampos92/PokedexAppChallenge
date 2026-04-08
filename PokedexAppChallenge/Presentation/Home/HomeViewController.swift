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
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var viewModel: HomeViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
        setupCollection()
        setupSearch()
        bindViewModel()
        
        viewModel.fetchPokemons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    // MARK: - Button action
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        let query = searchBar.text ?? ""
        
        if query.isEmpty {
            viewModel.resetSearch()
        } else {
            viewModel.searchPokemon(query: query)
        }
    }
    
    @IBAction func textDidChange(_ sender: Any) {
        let query = searchBar.text ?? ""
        
        if query.isEmpty {
            viewModel.resetSearch()
        }
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
    
    func setupSearch() {
        searchBar.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        
        searchView.backgroundColor = UIColor(named: "backgroundPrimary")
        searchBar.backgroundColor = UIColor(named: "backgroundPrimary")
        
        // MARK: - Button
        searchButton.backgroundColor = UIColor(named: "PrimaryYellow")
        searchButton.clipsToBounds = true
        
        searchButton.setImage(UIImage(named: "Research"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit // TODO: Fix image scale (image are blurred)
        
        // MARK: - TextField
        searchBar.placeholder = "Buscar" // TODO: Change placeholder color text
        searchBar.font = UIFont(name: "Montserrat-Regular", size: 12)
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        searchBar.leftView = leftPadding
        searchBar.leftViewMode = .always
        
        // TODO: Limit the text field's content area so it doesn't overlap with the button
        
        searchBar.textColor = UIColor(named: "DarkGrey")
        searchBar.backgroundColor = UIColor(named: "backgroundPrimary")
        searchBar.layer.cornerRadius = 18
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor(named: "NeutralGrey")?.cgColor
        searchBar.layer.masksToBounds = true
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
        
        viewModel.onReloadData = { [weak self] in
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
