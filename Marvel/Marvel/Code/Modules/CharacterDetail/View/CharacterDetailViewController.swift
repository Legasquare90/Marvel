//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import UIKit

class CharacterDetailViewController: BaseViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var comicCollectionLinkView: UIView!
    @IBOutlet weak var comicCollectionLinkLabel: UILabel!
    @IBOutlet weak var detailLinkView: UIView!
    @IBOutlet weak var detailLinkLabel: UILabel!
    @IBOutlet weak var wikiLinkView: UIView!
    @IBOutlet weak var wikiLinkLabel: UILabel!
    
    var character: Character!

    // MARK: - Architecture
    
    private lazy var presenter: CharacterDetailPresenterInput = self.makePresenter()

    private func makePresenter() -> CharacterDetailPresenterInput {
        return CharacterDetailPresenter(viewInterface: self)
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterImageView.layer.cornerRadius = characterImageView.frame.size.height / 2
        
        if UIDevice.current.orientation == .portrait {
            self.nameLabel.textAlignment = .left
            self.descriptionLabel.textAlignment = .left
        } else {
            self.nameLabel.textAlignment = .center
            self.descriptionLabel.textAlignment = .center
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        comicCollectionLinkLabel.text = "character_detail_link_comics".localized
        detailLinkLabel.text = "character_detail_link_detail".localized
        wikiLinkLabel.text = "character_detail_link_wiki".localized
        collectionsSegmentedControl.setTitle("character_detail_table_comics".localized, forSegmentAt: 0)
        collectionsSegmentedControl.setTitle("character_detail_table_stories".localized, forSegmentAt: 1)
        collectionsSegmentedControl.setTitle("character_detail_table_events".localized, forSegmentAt: 2)
        collectionsSegmentedControl.setTitle("character_detail_table_series".localized, forSegmentAt: 3)

        nameLabel.text = character.name
    }

    // MARK: - IBActions

    @IBAction func comicCollectionLinkAction(_ sender: Any) {
        
    }
    
    @IBAction func detailLinkAction(_ sender: Any) {
        
    }
    
    @IBAction func wikiLinkAction(_ sender: Any) {
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
    }
    
    @IBAction func collectionsSegmentedControlDidChange(_ sender: Any) {
        
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension CharacterDetailViewController: CharacterDetailPresenterOutput {

}
