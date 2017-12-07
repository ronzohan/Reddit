//
//  ListingBuilder.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol ListingDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var repository: SubredditServiceable { get }
}

final class ListingComponent: Component<ListingDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    fileprivate let subreddit: String

    var repository: SubredditServiceable {
        return dependency.repository
    }

    init(dependency: ListingDependency, subreddit: String) {
        self.subreddit = subreddit
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol ListingBuildable: Buildable {
    func build(withListener listener: ListingListener, subreddit: String) -> ListingRouting
}

final class ListingBuilder: Builder<ListingDependency>, ListingBuildable {

    override init(dependency: ListingDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ListingListener, subreddit: String) -> ListingRouting {
        let component = ListingComponent(dependency: dependency, subreddit: subreddit)
        let viewController = ListingViewController()
        let interactor = ListingInteractor(presenter: viewController, 
                                           repository: component.repository, 
                                           subreddit: component.subreddit)
        interactor.listener = listener

        let thingDetailBuilder = ThingDetailBuilder(dependency: component)
        return ListingRouter(interactor: interactor, 
                             viewController: viewController, 
                             thingDetailBuilder: thingDetailBuilder)
    }
}
