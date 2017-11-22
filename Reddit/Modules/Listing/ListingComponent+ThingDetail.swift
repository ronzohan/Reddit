//
//  ListingComponent+ThingDetail.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/22/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Listing to provide for the ThingDetail scope.
// TODO: Update ListingDependency protocol to inherit this protocol.
protocol ListingDependencyThingDetail: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Listing to provide dependencies
    // for the ThingDetail scope.
}

extension ListingComponent: ThingDetailDependency {

    // TODO: Implement properties to provide for ThingDetail scope.
}
