//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import UIKit
import Kingfisher

enum TableSection: Int {
    case Comics = 0
    case Stories
    case Events
    case Series
}

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
    
    var sectionSelected: TableSection = .Comics

    // MARK: - Architecture
    
    private lazy var navigator: CharacterDetailNavigator = CharacterDetailNavigator(from: self)

    private lazy var presenter: CharacterDetailPresenterInput = self.makePresenter()

    private func makePresenter() -> CharacterDetailPresenterInput {
        return CharacterDetailPresenter(viewInterface: self)
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        
        setLocalizableStrings()
        setCharacterData()
        checkAlignment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        characterImageView.layer.cornerRadius = characterImageView.frame.size.height / 2
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        checkAlignment()
    }

    // MARK: - IBActions

    @IBAction func comicCollectionLinkAction(_ sender: Any) {
        if let urlString = character.urls?.first(where: { $0.type == .comiclink })?.url, let url = URL(string: urlString) {
            navigator.navigate(style: .openURL(url: url))
        }
    }
    
    @IBAction func detailLinkAction(_ sender: Any) {
        if let urlString = character.urls?.first(where: { $0.type == .detail })?.url, let url = URL(string: urlString) {
            navigator.navigate(style: .openURL(url: url))
        }
    }
    
    @IBAction func wikiLinkAction(_ sender: Any) {
        if let urlString = character.urls?.first(where: { $0.type == .wiki })?.url, let url = URL(string: urlString) {
            navigator.navigate(style: .openURL(url: url))
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        navigator.navigate(style: .dismiss)
    }
    
    @IBAction func collectionsSegmentedControlDidChange(_ sender: Any) {
        self.sectionSelected = TableSection(rawValue: collectionsSegmentedControl.selectedSegmentIndex) ?? .Comics
        self.tableView.reloadData()
        if self.tableView.numberOfRows(inSection: 0) > 0 {
            self.tableView.scrollToRow(at: IndexPath (item: 0, section: 0), at: UITableView.ScrollPosition.top, animated: false)
        }
    }
    
    // MARK: - Other methods

    func setCharacterData() {
        let imageURL = String(format: "%@.%@", (character.thumbnail?.path ?? ""), (character.thumbnail?.thumbnailExtension?.rawValue ?? ""))
        let url = URL(string: imageURL)
        characterImageView.kf.setImage(with: url)
        nameLabel.text = character.name
        descriptionLabel.text = character.resultDescription
        
        for url in (character.urls ?? []) {
            switch url.type {
            case .comiclink:
                comicCollectionLinkView.isHidden = false
            case .detail:
                detailLinkView.isHidden = false
            case .wiki:
                wikiLinkView.isHidden = false
            default:
                break
            }
        }
    }
    
    func setLocalizableStrings() {
        comicCollectionLinkLabel.text = "character_detail_link_comics".localized
        detailLinkLabel.text = "character_detail_link_detail".localized
        wikiLinkLabel.text = "character_detail_link_wiki".localized
        collectionsSegmentedControl.setTitle("character_detail_table_comics".localized, forSegmentAt: 0)
        collectionsSegmentedControl.setTitle("character_detail_table_stories".localized, forSegmentAt: 1)
        collectionsSegmentedControl.setTitle("character_detail_table_events".localized, forSegmentAt: 2)
        collectionsSegmentedControl.setTitle("character_detail_table_series".localized, forSegmentAt: 3)
    }
    
    func checkAlignment() {
        if UIDevice.current.orientation == .portrait {
            self.nameLabel.textAlignment = .left
            self.descriptionLabel.textAlignment = .left
        } else {
            self.nameLabel.textAlignment = .center
            self.descriptionLabel.textAlignment = .center
        }
    }
}

// MARK: -

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.sectionSelected {
        case .Comics:
            return character.comics?.items?.count ?? 0
        case .Stories:
            return character.stories?.items?.count ?? 0
        case .Events:
            return character.events?.items?.count ?? 0
        case .Series:
            return character.series?.items?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name = ""
        switch self.sectionSelected {
        case .Comics:
            name = character.comics?.items?[indexPath.row].name ?? ""
        case .Stories:
            name = character.stories?.items?[indexPath.row].name ?? ""
        case .Events:
            name = character.events?.items?[indexPath.row].name ?? ""
        case .Series:
            name = character.series?.items?[indexPath.row].name ?? ""
        }

        let basicCell = UITableViewCell()
        basicCell.textLabel?.text = name
        basicCell.textLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        basicCell.textLabel?.numberOfLines = 2
        return basicCell
    }
}

// MARK: -

extension CharacterDetailViewController: CharacterDetailPresenterOutput {

}

// MARK: -

extension CharacterDetailViewController: CharacterDetailNavigatorDelegate {

}
