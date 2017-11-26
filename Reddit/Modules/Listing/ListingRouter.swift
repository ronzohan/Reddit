//
//  ListingRouter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol ListingInteractable: Interactable, ThingDetailListener {
    weak var router: ListingRouting? { get set }
    weak var listener: ListingListener? { get set }
}

protocol ListingViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func presentWithCardAnimation(viewController: ViewControllable)
}

final class ListingRouter: ViewableRouter<ListingInteractable, ListingViewControllable>, ListingRouting {

    let thingDetailBuilder: ThingDetailBuildable

    init(interactor: ListingInteractable, 
         viewController: ListingViewControllable, 
         thingDetailBuilder: ThingDetailBuildable) {
        self.thingDetailBuilder = thingDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToThingDetail(withID id: String) {
        let thingDetail = thingDetailBuilder.build(withListener: interactor, thingId: id)
        attachChild(thingDetail)
        viewController.presentWithCardAnimation(viewController: thingDetail.viewControllable)
    }
}
