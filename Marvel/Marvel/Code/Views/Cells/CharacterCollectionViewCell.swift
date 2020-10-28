//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 09/07/2020.
//

import UIKit
import Kingfisher

struct CharacterCellDesign {
    var name: String
    var imageURL: String

    init(name: String = "", imageURL: String = "") {
        self.name = name
        self.imageURL = imageURL
    }
}

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterImageView.layer.cornerRadius = self.characterImageView.frame.size.height / 2
        characterImageView.clipsToBounds = true
    }
    
    func setupCell(design: CharacterCellDesign) {
        let url = URL(string: design.imageURL)
        characterImageView.kf.setImage(with: url)
        nameLabel.text = design.name
    }

}
