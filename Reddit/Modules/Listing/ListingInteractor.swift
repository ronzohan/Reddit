//
//  ListingInteractor.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 11/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import RIBs
import RxSwift

protocol ListingRouting: ViewableRouting {
    // Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToThingDetail(withID id: String)
}

protocol ListingPresentable: Presentable {
    weak var listener: ListingPresentableListener? { get set }
    func reloadListing()
    func updateListingNextPage()
    
}

protocol ListingListener: class {
    // Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ListingInteractor: PresentableInteractor<ListingPresentable>, 
ListingInteractable, ListingPresentableListener {
    weak var router: ListingRouting?
    weak var listener: ListingListener?

    var after: String?
    var before: String?
    let subreddit: String

    private var isNextPageQueried: Bool = false
    
    var sections: [ListingSection] = []
    
    let repository: ListingUseCase

    init(presenter: ListingPresentable, repository: ListingUseCase, subreddit: String) {
        self.repository = repository
        self.subreddit = subreddit
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        loadListingPage()
    }

    func getListing() -> Observable<ListingSection> {
        return repository.fetchHotListing(subreddit: subreddit, after: after, before: before)
            .do(onNext: { listing in
                // Update current after and before values for loading next page
                self.after = listing.after
                self.before = listing.before
            })
            .map({ (listing) -> ListingSection in
                let section = self.sectionModels(forListing: listing)

                return section
            })
    }

    func sectionModels(forListing listing: Listing) -> ListingSection {
        let links = listing.children.flatMap { (thing) -> Link? in
            return thing as? Link
        }

        return ListingSection.linkRows(links: links)
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
        if case let ListingSection.linkRows(links) = sections[indexPath.section],
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
