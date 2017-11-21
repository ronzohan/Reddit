//
//  ThingDetailRouter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol ThingDetailInteractable: Interactable {
    weak var router: ThingDetailRouting? { get set }
    weak var listener: ThingDetailListener? { get set }
}

protocol ThingDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ThingDetailRouter: ViewableRouter<ThingDetailInteractable, ThingDetailViewControllable>, ThingDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ThingDetailInteractable, viewController: ThingDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
