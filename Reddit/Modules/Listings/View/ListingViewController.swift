//
//  ListingViewController.swift
//  Listing
//
//  Created by Ron Daryl Magno on 8/11/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListingViewController: UIViewController {
    // MARK: - Properties
    var viewModel: ListingViewModel!

    var loadingAlert: UIAlertController?

    let disposeBag = DisposeBag()

    let datasources = ListingDatasource()

    // MARK: - Subviews
    lazy var listingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ImageLinkTableViewCell.self,
                           forCellReuseIdentifier: ImageLinkTableViewCell.reuseIdentifier)
        tableView.register(UrlLinkTableViewCell.self,
                           forCellReuseIdentifier: UrlLinkTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.delegate = self.datasources
        tableView.dataSource = self.datasources

        return tableView
    }()

    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray

        return loader
    }()

    // MARK: - Init
    init(viewModel: ListingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

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

        viewModel.subreddit = "all"
        viewModel.getListing()
            .subscribe(onNext: { sections in
                self.datasources.dataSource.append(sections)
                self.listingTableView.reloadData()
            })
            .disposed(by: disposeBag)

        datasources.onLoadNextPage {
            self.viewModel.getListing()
                .subscribe(onNext: { sections in
                    self.datasources.dataSource.append(sections)
                    let index = IndexSet(integer: self.datasources.dataSource.count - 1)
                    self.listingTableView.insertSections(index, with: .bottom)
                })
                .addDisposableTo(self.disposeBag)
        }
    }
}
