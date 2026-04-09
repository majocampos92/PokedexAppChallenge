//
//  ViewController.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import UIKit
import SwiftUI

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
        
        collectionView.setGridLayout(columns: 2, includeHeader: true)
        
        collectionView.backgroundColor = UIColor(named: "backgroundPrimary")

        collectionView.register(
            UINib(nibName: PokemonCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier
        )
        
        collectionView.register(
            UINib(nibName: HeaderPokemonCollectionReusableView.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderPokemonCollectionReusableView.identifier
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
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.collectionView.setGridLayout(columns: 2, includeHeader: true, headerHeight: (self.viewModel.isSearching ? 40 : 0))
                
                self.collectionView.performBatchUpdates({
                            self.collectionView.reloadSections(IndexSet(integer: 0))
                        })
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
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPokemonCollectionReusableView.identifier, for: indexPath) as! HeaderPokemonCollectionReusableView

        if viewModel.isSearching {
            if viewModel.pokemons.isEmpty {
                header.configure(text: "No se encontraron resultados")
            } else {
                header.configure(text: "Resultado de búsqueda")
            }
        } else {
            header.configure(text: "")
        }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pokemon = self.viewModel.pokemons[indexPath.row]
        
        guard let url = pokemon.url else { return }
        
        let swiftUIView = PokemonDetailView(url: String(describing: url))
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        hostingController.title = pokemon.name
        navigationController?.pushViewController(hostingController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        let threshold = collectionView.contentSize.height - scrollView.frame.size.height

        if position > threshold - 100 {
            viewModel.fetchPokemons()
        }
    }
}
