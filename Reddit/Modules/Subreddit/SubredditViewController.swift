//
//  ListingViewController.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SnapKit

protocol SubredditPresentableListener: class {
    // Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    var sections: [SubredditSection] { get }
    
    func loadNextListingPage(withIndexPath indexPath: IndexPath)
    func didSelectItem(atIndexPath: IndexPath)
}

final class SubredditViewController: UIViewController, SubredditPresentable, SubredditViewControllable {

    /// The UIKit view representation of this view.
    public final var uiviewController: UIViewController { return self }

    var cardTransition = CardTransitioningDelegate()
    
    weak var listener: SubredditPresentableListener?

    let disposeBag = DisposeBag()
    
    var estimatedHeightCache: [IndexPath: CGFloat] = [:]

    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ImageLinkTableViewCell.self,
                           forCellReuseIdentifier: ImageLinkTableViewCell.reuseIdentifier)
        tableView.register(UrlLinkTableViewCell.self,
                           forCellReuseIdentifier: UrlLinkTableViewCell.reuseIdentifier)
        tableView.register(LoadingCell.self,
                           forCellReuseIdentifier: LoadingCell.reuseIdentifier)
        
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.delegate = self
        tableView.dataSource = self
        
        let activityView = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                 y: 0,
                                                                 width: 100,
                                                                 height: 40))
        activityView.startAnimating()
        activityView.color = UIColor.white
        tableView.tableFooterView = activityView

        return tableView
    }()

    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top)
            make.bottom.equalTo(view.safeArea.bottom)
            make.leading.equalTo(view.safeArea.leading)
            make.trailing.equalTo(view.safeArea.trailing)
        }
        tableView.backgroundColor = Theme.gray
        
        title = "Home"
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // TODO Test this
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (_) in
            self.tableView.reloadData()
            
            if let indexPaths = self.tableView.indexPathsForVisibleRows {
                self.tableView.reloadRows(at: indexPaths, with: .automatic)
            }
        }, completion: nil)
    }

    // MARK: - ListingViewControllable
    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func presentWithCardAnimation(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .custom
        viewController.uiviewController.transitioningDelegate = cardTransition
        present(viewController.uiviewController, animated: true, completion: nil)
    }
}

// MARK: - Datasource
extension SubredditViewController: UITableViewDataSource {
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
        case .loadingIndicator:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = listener?.sections else {
            return UITableViewCell()
        }
        
        switch sections[indexPath.section] {
        case let .linkRows(links: links):
            return linkCellForLink(link: links[indexPath.row], tableView: tableView, forRowAt: indexPath)
        case .loadingIndicator:
            return loadingCellFor(tableView: tableView, forRowAt: indexPath)
        }
    }
    
    func linkCellForLink(link: Link,
                         tableView: UITableView,
                         forRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell?
        
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
    
    func loadingCellFor(tableView: UITableView, forRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LoadingCell = tableView.dequeueReusableCell(forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        cell.loadingIndicator.startAnimating()
        
        return cell
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        estimatedHeightCache[indexPath] = cell.frame.height

        listener?.loadNextListingPage(withIndexPath: indexPath)
    }
    
    func tableView(_: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedHeightCache[indexPath] ?? 100
    }
    
    func reloadListing() {
        tableView.reloadData()
    }
    
    func updateListingNextPage() {
        guard let listener = listener else {
            return
        }
        
        let index = IndexSet(integer: listener.sections.count - 1)
        tableView.insertSections(index, with: .bottom)
    }
    
    func configureLinkTableViewCell(cell: UITableViewCell, link: Link) {
        let viewModel = LinkCellViewModel(link: link)
        
        if var linkCell = cell as? ILinkCell {
            linkCell.viewModel = viewModel
            linkCell.configure()
        }
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

extension SubredditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentView = (tableView.cellForRow(at: indexPath) as? Contentable)?.linkContentView
        
        let rect = CGRect(origin: CGPoint.zero, size: contentView!.frame.size)
        
        cardTransition.originFrame = contentView!.convert(rect, to: view)
        
        listener?.didSelectItem(atIndexPath: indexPath)
    }
}
