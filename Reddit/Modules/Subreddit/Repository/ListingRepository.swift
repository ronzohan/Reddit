//
//  ListingRepository.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/3/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RxSwift

protocol ListingUseCase {
    func fetchHotListing(subreddit: String,
                         after: String?,
                         before: String?) -> Observable<Listing>
}
