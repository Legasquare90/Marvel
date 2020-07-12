//
//  Navigator.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 12/07/2020.
//

import Foundation

enum Style {
    case push
    case modal
    case back
    case dismiss
    case openURL(url: URL)
}

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination, style: Style)
}
