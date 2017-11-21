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
}

protocol ThingDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ThingDetailInteractor: PresentableInteractor<ThingDetailPresentable>, ThingDetailInteractable, ThingDetailPresentableListener {

    weak var router: ThingDetailRouting?
    weak var listener: ThingDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ThingDetailPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
