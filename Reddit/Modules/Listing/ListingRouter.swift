//
//  ListingRouter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol ListingInteractable: Interactable {
    weak var router: ListingRouting? { get set }
    weak var listener: ListingListener? { get set }
}

protocol ListingViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ListingRouter: ViewableRouter<ListingInteractable, ListingViewControllable>, ListingRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ListingInteractable, viewController: ListingViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
