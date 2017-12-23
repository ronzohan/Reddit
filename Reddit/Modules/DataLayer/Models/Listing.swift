//
//  Listing.swift
//  DataLayer
//
//  Created by Ron Daryl Magno on 8/13/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//
//  Source: https://github.com/reddit/reddit/wiki/JSON#listing

import Foundation

enum ListingDataKeys: String, CodingKey {
    case after
    case before
    case modHash = "modhash"
    case children
}

struct Listing {
    var modHash: String? = ""
    var after: String?
    var before: String?
    var children: [Thing] = []
}

extension Listing: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RedditAnyKeys.self)
        
        let dataContainer = try container.nestedContainer(keyedBy: ListingDataKeys.self, forKey: .data)
        
        let after = try? dataContainer.decode(String.self, forKey: .after)
        let before = try? dataContainer.decode(String.self, forKey: .before)
        let modhash = try? dataContainer.decode(String.self, forKey: .modHash)

        var children: [Thing] = []
        var childrenContainer = try dataContainer.nestedUnkeyedContainer(forKey: .children)

        // Need to have a reference to the children container
        // so that then childrenContainer does successfully decode
        // it won't update childrenContainer currentIndex twice
        var thingsContainer = childrenContainer

        // We need to manually parse the things in the children
        // To do so, we must iterate each children and check what is their thing kind
        // then instantiate the Thing model accordingly
        while !childrenContainer.isAtEnd {
            let thingContainer = try childrenContainer.nestedContainer(keyedBy: ThingKeys.self)
            let kind = try thingContainer.decode(ThingKind.self, forKey: .kind)

            switch kind {
            case .link:
                let linkThingContainer = try thingsContainer.nestedContainer(keyedBy: RedditAnyKeys.self)
                let link = try linkThingContainer.decode(Link.self, forKey: .data)
                children.append(link)
            }
        }

        self.init(modHash: modhash, after: after, before: before, children: children)
    }
}
