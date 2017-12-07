//
//  RootBuilder.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol RootDependency: RootDependencyListing {
}

final class RootComponent: Component<RootDependency> {
    let rootViewController: RootViewController

    let subredditService: SubredditServiceable

    init(dependency: RootDependency,
         rootViewController: RootViewController,
         repository: SubredditServiceable) {
        self.subredditService = repository
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController,
                                      repository: dependency.listingService)
        let interactor = RootInteractor(presenter: viewController)

        let listingBuilder = ListingBuilder(dependency: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          listingBuilder: listingBuilder)
    }
}
