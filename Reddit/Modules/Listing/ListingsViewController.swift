//
//  ListingViewController.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol ListingPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func loadNextListingPage(withIndexPath indexPath: IndexPath)
    var sections: [ListingSection] { get }
}

final class ListingViewController: UIViewController, ListingPresentable, ListingViewControllable {

    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    weak var listener: ListingPresentableListener?

    let disposeBag = DisposeBag()
    
    var estimatedHeightCache: [IndexPath: CGFloat] = [:]

    // MARK: - Subviews
    lazy var listingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ImageLinkTableViewCell.self,
                           forCellReuseIdentifier: ImageLinkTableViewCell.reuseIdentifier)
        tableView.register(UrlLinkTableViewCell.self,
                           forCellReuseIdentifier: UrlLinkTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        view.addSubview(listingTableView)
        listingTableView.translatesAutoresizingMaskIntoConstraints = false
        listingTableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        listingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        listingTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listingTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listingTableView.backgroundColor = UIColor.lightGray
    }

    func reloadListing() {
        listingTableView.reloadData()
    }

    func updateListingNextPage() {
        guard let listener = listener else {
            return
        }

        let index = IndexSet(integer: listener.sections.count - 1)
        listingTableView.insertSections(index, with: .bottom)
    }
    
    func configureLinkTableViewCell(cell: BaseLinkTableViewCell, link: Link) {
        let viewModel = LinkCellViewModel(link: link)
        
        cell.viewModel = viewModel
        cell.configure()
    }
    
    func urlLinkTableViewCellFor(tableView: UITableView,
                                 indexPath: IndexPath) -> UrlLinkTableViewCell? {
        let cell: UrlLinkTableViewCell? = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        return cell
    }
    
    func imageLinkTableViewCellFor(tableView: UITableView,
                                   indexPath: IndexPath) -> ImageLinkTableViewCell? {
        let cell: ImageLinkTableViewCell? = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        return cell
    }
}

// MARK: - Datasource
extension ListingViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return listener?.sections.count ?? 0
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = listener?.sections else {
            return 0
        }

        switch sections[section] {
        case let .linkRows(links):
            return links.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = listener?.sections else {
            return UITableViewCell()
        }
        
        switch sections[indexPath.section] {
        case let .linkRows(links: links):
            return linkCellForLink(link: links[indexPath.row], tableView: tableView, forRowAt: indexPath)
        }
    }
    
    func linkCellForLink(link: Link,
                         tableView: UITableView,
                         forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseLinkTableViewCell?
        
        switch link.postHint {
        case .link:
            cell = urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
        case .image:
            cell = imageLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
        default:
            cell = urlLinkTableViewCellFor(tableView: tableView, indexPath: indexPath)
        }
        
        guard let linkCell = cell else {
            return UITableViewCell()
        }
        
        configureLinkTableViewCell(cell: linkCell, link: link)
        
        return linkCell
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        estimatedHeightCache[indexPath] = cell.frame.height
        listener?.loadNextListingPage(withIndexPath: indexPath)
    }
    
    func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedHeightCache[indexPath] ?? 100
    }
}

extension ListingViewController: UITableViewDelegate {}
