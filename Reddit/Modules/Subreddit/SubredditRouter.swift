//
//  SubreditRouter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

protocol SubredditInteractable: Interactable, ThingDetailListener {
    weak var router: SubredditRouting? { get set }
    weak var listener: SubredditListener? { get set }
}

protocol SubredditViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func presentWithCardAnimation(viewController: ViewControllable)
}

final class SubreditRouter: ViewableRouter<SubredditInteractable, SubredditViewControllable>, SubredditRouting {

    let thingDetailBuilder: ThingDetailBuildable

    init(interactor: SubredditInteractable, 
         viewController: SubredditViewControllable, 
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
