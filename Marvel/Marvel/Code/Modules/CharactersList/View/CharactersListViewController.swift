//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import UIKit

class CharactersListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let offsetCollection: CGFloat = 32.0
    let cellsPerRow = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5

    // MARK: - Architecture
    
    private lazy var presenter: CharactersListPresenterInput = self.makePresenter()

    private func makePresenter() -> CharactersListPresenterInput {
        return CharactersListPresenter(viewInterface: self)
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.placeholder = "characters_list_search_placeholder".localized
        searchTextField.placeHolderColor = UIColor.darkGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        
        presenter.getCharacters()
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        presenter.filterCharacters(search: searchTextField.text ?? "")
    }
}

extension CharactersListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.countCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let design = presenter.getDesign(index: indexPath.row)
        cell.setupCell(design: design)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - offsetCollection) / CGFloat(cellsPerRow)
        return CGSize(width: size, height: size)
    }
}

extension CharactersListViewController: CharactersListPresenterOutput {
    func refreshView() {
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        
    }
}

