//
//  CharacterDetailNavigator.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 12/07/2020.
//

import UIKit

protocol CharacterDetailNavigatorDelegate {

}

class CharacterDetailNavigator: Navigator {
    
    enum Destination {
        case none
    }
    
    private var delegate: CharacterDetailNavigatorDelegate?
    private weak var origin: UIViewController?

    // MARK: - Initializer

    init(from origin: UIViewController) {
        self.delegate = origin as? CharacterDetailNavigatorDelegate
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
            case .none:
                return nil
        }
    }
}
