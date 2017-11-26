//
//  ThingDetailInteractor.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs
import RxSwift

protocol ThingDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ThingDetailPresentable: Presentable {
    weak var listener: ThingDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setThingDetail(title: String)
}

protocol ThingDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ThingDetailInteractor: PresentableInteractor<ThingDetailPresentable>, ThingDetailInteractable, ThingDetailPresentableListener {
    weak var router: ThingDetailRouting?
    weak var listener: ThingDetailListener?
    
    var thingId: String

    init(presenter: ThingDetailPresentable, thingId: String) {
        self.thingId = thingId
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func getThingDetail() {
        presenter.setThingDetail(title: "Dota2 reworked ranked system")
    }
}
