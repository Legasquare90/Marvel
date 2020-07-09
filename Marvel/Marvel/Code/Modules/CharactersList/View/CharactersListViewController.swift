//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 06/07/2020.
//

import UIKit

class CharactersListViewController: UIViewController {

    private lazy var presenter: CharactersListPresenterInput = self.makePresenter()

    private func makePresenter() -> CharactersListPresenterInput {
        return CharactersListPresenter(viewInterface: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CharactersListViewController: CharactersListPresenterOutput {
    
}

