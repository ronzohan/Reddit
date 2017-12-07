//
//  ListingInteractor.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs
import RxSwift

protocol SubredditRouting: ViewableRouting {
    // Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToThingDetail(withID id: String)
}

protocol SubredditPresentable: Presentable {
    weak var listener: SubredditPresentableListener? { get set }
    func reloadListing()
    func updateListingNextPage()
}

protocol SubredditListener: class {
    // Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SubredditInteractor: PresentableInteractor<SubredditPresentable>, 
SubredditInteractable, SubredditPresentableListener {
    weak var router: SubredditRouting?
    weak var listener: SubredditListener?

    var after: String?
    var before: String?
    var subreddit: String

    private var isNextPageQueried: Bool = false
    
    var sections: [SubredditSection] = []
    
    let subredditService: SubredditServiceable

    init(presenter: SubredditPresentable, 
         service: SubredditServiceable, 
         subreddit: String) {
        self.subredditService = service
        self.subreddit = subreddit
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()

        loadListingPage()
    }

    func getListing() -> Observable<SubredditSection> {
        var bodyParams: [String: Any] = [:]
        bodyParams["after"] = after
        bodyParams["before"] = before
        
        return subredditService.hotPosts(forSubreddit: subreddit, bodyParams: bodyParams)
            .do(onNext: { listing in
                // Update current after and before values for loading next page
                self.after = listing.after
                self.before = listing.before
            })
            .map({ (listing) -> SubredditSection in
                let section = self.sectionModels(forListing: listing)
                
                return section
            })
    }

    func sectionModels(forListing listing: Listing) -> SubredditSection {
        let links = listing.children.flatMap { (thing) -> Link? in
            return thing as? Link
        }

        return SubredditSection.linkRows(links: links)
    }
    
    func loadListingPage() {
        getListing()
            .subscribe(onNext: { section in
                self.sections = [section]
                self.presenter.reloadListing()
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    func loadNextListingPage(withIndexPath indexPath: IndexPath) {
        if shouldLoadNextPage(withIndexPath: indexPath) {
            isNextPageQueried = true
            
            getListing()
                .subscribe(onNext: { (section) in
                    self.isNextPageQueried = false
                    self.sections.append(section)
                    self.presenter.updateListingNextPage()
                })
                .disposeOnDeactivate(interactor: self)
        }
    }
    
    func shouldLoadNextPage(withIndexPath indexPath: IndexPath) -> Bool {
        if case let SubredditSection.linkRows(links) = sections[indexPath.section],
            indexPath.row == links.count - 1 &&
                !sections.isEmpty &&
                indexPath.section == sections.count - 1 &&
                !isNextPageQueried {
            return true
        } else {
            return false
        }
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .linkRows(let links):
            router?.routeToThingDetail(withID: links[indexPath.row].id)
        }
    }
}
