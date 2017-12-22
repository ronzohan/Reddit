//
//  LinkCellViewModel.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/5/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class LinkCellViewModel {
    var meta: String {
        let date = Date(timeInterval: link.createdUTC)

        let timeIntervalString: String

        if let interval = Date.timeIntervalString(fromDate: date, toDate: Date()) {
            timeIntervalString = " • \(interval)"
        } else {
            timeIntervalString = ""
        }

        let cleanDomain = link.domain.replacingOccurrences(of: ".com", with: "")

        return "\(link.subredditNamePrefixed)\(timeIntervalString) • \(cleanDomain)"
    }

    var title: String {
        return "\(link.title)"
    }

    var imageUrl: String? {
        let url: String?

        guard !link.preview.images.isEmpty else {
            return nil
        }

        if !link.preview.images[0].resolutions.isEmpty {
            url = link.preview.images[0].resolutions[link.preview.images[0].resolutions.count - 1].url
        } else {
            url = nil
        }
        
        return url
    }

    var postHint: PostHint {
        return link.postHint
    }

    private var link: Link
    
    var minimumCellHeight: Double = 100

    init(link: Link) {
        self.link = link
    }

    func cellHeight(forWidth width: Double) -> Double {
        var previewHeight: Double = 0

        if !link.preview.images.isEmpty {
            // Find the most apprioriate width
            for i in link.preview.images[0].resolutions where i.width < width {
                
                previewHeight = i.height * (width / i.width)
            }

            if !link.preview.enabled {
               previewHeight = minimumCellHeight
            }

        } else { 
            previewHeight = minimumCellHeight
        }
        
   
        return previewHeight
    }
}
