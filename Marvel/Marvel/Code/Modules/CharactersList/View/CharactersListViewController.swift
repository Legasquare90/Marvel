//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import UIKit
import SwiftMessageBar

class CharactersListViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var spinnerImageView: UIImageView!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    let offsetCollection: CGFloat = 32.0
    let cellsPerRow = UIDevice.current.userInterfaceIdiom == .phone ? 3 : 5

    var isLoadingViewHidden = false
    var searchTimer: Timer?
    
    // MARK: - Architecture
    
    private lazy var navigator: CharactersListNavigator = CharactersListNavigator(from: self)

    private lazy var presenter: CharactersListPresenterInput = self.makePresenter()

    private func makePresenter() -> CharactersListPresenterInput {
        return CharactersListPresenter(viewInterface: self)
    }
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchIndicator.isHidden = true
        
        searchTextField.delegate = self
        searchTextField.placeholder = "characters_list_search_placeholder".localized
        searchTextField.placeHolderColor = UIColor.darkGray
        searchTextField.textColor = UIColor.black
        
        loadingView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCollectionViewCell")
        
        spinnerImageView.startRotation()
        
        presenter.getCharacters()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    // MARK: - IBActions

    @IBAction func textFieldDidChange(_ sender: Any) {
        presenter.filterCharacters(search: searchTextField.text ?? "")
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchCharacter), userInfo: nil, repeats: false)
    }
    
    // MARK: - Other methods
    
    @objc func searchCharacter() {
        if let search = searchTextField.text, search.count >= 3 {
            if presenter.isThereMoreCharacters() {
                searchIndicator.isHidden = false
                presenter.searchCharacters(search: search)
            }
        }
    }
    
    func showContentAfterLoad() {
        if !isLoadingViewHidden {
            isLoadingViewHidden = true
            spinnerImageView.stopRotation()
            let largeSide = (UIDevice.current.orientation != .landscapeLeft && UIDevice.current.orientation != .landscapeRight) ? self.view.frame.size.height : self.view.frame.size.width
            loadingView.dismissScalingAndMovingDown(scale: 0.7, verticalPosition: largeSide * 1.5)
        }
    }

}

// MARK: - UICollectionView

extension CharactersListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.countCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.checkPagination(index: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let design = presenter.getDesign(index: indexPath.row)
        cell.setupCell(design: design)
        cell.contentView.layoutSubviews()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let largeSide = (UIDevice.current.orientation != .landscapeLeft && UIDevice.current.orientation != .landscapeRight) ? collectionView.frame.size.width : collectionView.frame.size.height
        let size = (largeSide - offsetCollection) / CGFloat(cellsPerRow)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let character = presenter.getCharacter(index: indexPath.row) {
            navigator.navigate(to: .showDetail(character: character), style: .modal)
        }
    }
}

// MARK: - UITextField

extension CharactersListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - CharactersListPresenterOutput

extension CharactersListViewController: CharactersListPresenterOutput {
    func refreshView() {
        showContentAfterLoad()
        collectionView.reloadData()
    }
    
    func searchFinished() {
        searchIndicator.isHidden = true
    }
    
    func showError() {
        showContentAfterLoad()
        SwiftMessageBar.showMessage(withTitle: "error_title".localized, message: "error_message".localized, type: .error)
    }
}

// MARK: - CharactersListNavigatorDelegate

extension CharactersListViewController: CharactersListNavigatorDelegate {

}
