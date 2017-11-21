//
//  RootRouter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, ListingListener {
    weak var router: RootRouting? { get set }
    weak var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    // MARK: - Private
    private let listingBuilder: ListingBuildable

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         listingBuilder: ListingBuildable) {
        self.listingBuilder = listingBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()

        routeToListing(withSubreddit: "all")
    }

    func routeToListing(withSubreddit subreddit: String) {
        let listing = listingBuilder.build(withListener: interactor, subreddit: subreddit)
        attachChild(listing)
        
        viewController.present(viewController: listing.viewControllable)
    }
}
