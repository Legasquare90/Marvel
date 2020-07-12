//
//  CharactersListNavigator.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 12/07/2020.
//

import UIKit

protocol CharactersListNavigatorDelegate {

}

class CharactersListNavigator: Navigator {
    
    enum Destination {
        case none
        case showDetail(character: Character)
    }
    
    private var delegate: CharactersListNavigatorDelegate?
    private weak var origin: UIViewController?

    // MARK: - Initializer

    init(from origin: UIViewController) {
        self.delegate = origin as? CharactersListNavigatorDelegate
        self.origin = origin
    }

    // MARK: - Navigator

    func navigate(to destination: Destination = .none, style: Style) {
        guard let originController = origin else {
            return
        }
        
        let controller: UIViewController? = makeViewController(for: destination)
        switch style {
        case .push:
            originController.navigationController?.pushViewController(controller!, animated: true)
        case .modal:
            originController.present(controller!, animated: true, completion: nil)
        case .back:
            originController.navigationController?.popViewController(animated: true)
        case .dismiss:
            originController.dismiss(animated: true, completion: nil)
        case .openURL(let url):
            UIApplication.shared.open(url)
        }
    }

    // MARK: - Private
    
    private func makeViewController(for destination: Destination) -> UIViewController? {
        switch destination {
            case .showDetail(let character):
                let controller: CharacterDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
                controller.character = character
                return controller
            case .none:
                return nil
        }
    }
}
