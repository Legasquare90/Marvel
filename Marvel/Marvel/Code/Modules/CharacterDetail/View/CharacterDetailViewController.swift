//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Jose Angel Cuadrado Mingo on 11/07/2020.
//

import UIKit
import Kingfisher
import SwiftMessageBar
import DZNEmptyDataSet

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
                
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        
        presenter.saveData(character: character)
        
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

// MARK: - UITableView

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(section: self.sectionSelected)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.checkPagination(index: indexPath.row, section: self.sectionSelected)

        let basicCell = UITableViewCell()
        basicCell.textLabel?.text = presenter.getContentTitle(index: indexPath.row, section: self.sectionSelected)
        basicCell.textLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        basicCell.textLabel?.numberOfLines = 2
        return basicCell
    }
}

// MARK: - DZNEmptyDataSet

extension CharacterDetailViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black]
        let string = presenter.getEmptyTitle(section: self.sectionSelected)
        return NSAttributedString(string: string, attributes: attributes)
    }
    
}

// MARK: - CharacterDetailPresenterOutput

extension CharacterDetailViewController: CharacterDetailPresenterOutput {
    func refreshView() {
        self.tableView.reloadData()
    }
    
    func showError() {
        SwiftMessageBar.showMessage(withTitle: "error_title".localized, message: "error_message".localized, type: .error)
    }
}

// MARK: - CharacterDetailNavigatorDelegate

extension CharacterDetailViewController: CharacterDetailNavigatorDelegate {

}
