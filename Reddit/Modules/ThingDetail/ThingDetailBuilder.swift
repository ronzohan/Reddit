//
//  ThingDetailBuilder.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol ThingDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ThingDetailComponent: Component<ThingDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var thingId: String
    
    init(dependency: ThingDetailDependency, thingId: String) {
        self.thingId = thingId
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol ThingDetailBuildable: Buildable {
    func build(withListener listener: ThingDetailListener, thingId: String) -> ThingDetailRouting
}

final class ThingDetailBuilder: Builder<ThingDetailDependency>, ThingDetailBuildable {

    override init(dependency: ThingDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ThingDetailListener, thingId: String) -> ThingDetailRouting {
        let component = ThingDetailComponent(dependency: dependency, thingId: thingId)
        let viewController = ThingDetailViewController()
        let interactor = ThingDetailInteractor(presenter: viewController, thingId: component.thingId)
        interactor.listener = listener
        return ThingDetailRouter(interactor: interactor, viewController: viewController)
    }
}
