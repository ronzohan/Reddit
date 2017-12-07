//
//  RootComponent+Listing.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Listing scope.
protocol RootDependencyListing: Dependency {
    
} 

extension RootComponent: SubredditDependency {
}
