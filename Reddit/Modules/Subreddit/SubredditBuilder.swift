//
//  ListingBuilder.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol SubredditDependency: Dependency {
}

final class SubredditComponent: Component<SubredditDependency> {
    fileprivate let subreddit: String

    var repository: SubredditServiceable {
        return ServiceFactory.makeSubredditService()
    }

    init(dependency: SubredditDependency, subreddit: String) {
        self.subreddit = subreddit
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SubredditBuildable: Buildable {
    func build(withListener listener: SubredditListener, subreddit: String) -> SubredditRouting
}

final class SubredditBuilder: Builder<SubredditDependency>, SubredditBuildable {

    override init(dependency: SubredditDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SubredditListener, subreddit: String) -> SubredditRouting {
        let component = SubredditComponent(dependency: dependency, subreddit: subreddit)
        let viewController = SubredditViewController()
        let interactor = SubredditInteractor(presenter: viewController, 
                                           service: component.repository, 
                                           subreddit: component.subreddit)
        interactor.listener = listener

        let thingDetailBuilder = ThingDetailBuilder(dependency: component)
        return SubreditRouter(interactor: interactor, 
                             viewController: viewController, 
                             thingDetailBuilder: thingDetailBuilder)
    }
}
