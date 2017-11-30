//
//  ListingServices.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct ListingServices: ListingUseCase {
    func fetchHotListing(subreddit: String,
                         after: String? = nil,
                         before: String? = nil
    ) -> Observable<Listing> {

        return Observable.create({ (observer) -> Disposable in
            let url = "https://www.reddit.com/r/\(subreddit)/.json"

            let afterHash: String
            let beforeHash: String

            if let after = after {
                afterHash = after
            } else {
                afterHash = ""
            }

            if let before = before {
                beforeHash = before
            } else {
                beforeHash = ""
            }

            let parameters: [
                String: Any
            ] = [
                "raw_json": 1,
                "after": afterHash,
                "before": beforeHash
            ]

            let request = Alamofire.request(url, method: .get, parameters: parameters)
            
            request.responseData(completionHandler: { (response) in
                enum ResponseError: Error {
                    case noResponse
                }
    
                guard let data = response.data else {
                    observer.onError(ResponseError.noResponse)
                    observer.onCompleted()
                    return
                }
                
                do {
                    let listing = try JSONDecoder()
                        .decode(Listing.self, from: data) 
                    
                    observer.onNext(listing)
                } catch let error { 
                    debugPrint(error)
                    observer.onError(error)
                }

                observer.onCompleted()
            })

            return Disposables.create()
        })
    }
}
