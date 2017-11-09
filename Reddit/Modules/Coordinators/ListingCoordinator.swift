//
//  ListingCoordinator.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class ListingCoordinator {
    var listingVC: ListingViewController

    init() {
        let viewModel = ListingViewModel(useCase: ListingServices())
        listingVC = ListingViewController(viewModel: viewModel)
    }
}
