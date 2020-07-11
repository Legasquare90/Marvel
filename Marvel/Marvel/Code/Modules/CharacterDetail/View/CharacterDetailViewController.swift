//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import UIKit

class CharacterDetailViewController: BaseViewController {

    // MARK: - Architecture
    
    private lazy var presenter: CharacterDetailPresenterInput = self.makePresenter()

    private func makePresenter() -> CharacterDetailPresenterInput {
        return CharacterDetailPresenter(viewInterface: self)
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CharacterDetailViewController: CharacterDetailPresenterOutput {

}
