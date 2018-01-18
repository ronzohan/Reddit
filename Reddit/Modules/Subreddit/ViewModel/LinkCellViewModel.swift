//
//  LinkCellViewModel.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/5/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

class LinkCellViewModel {
    
    /// Minimum cell height in case the provided image is too large
    static var minimumCellHeight: Double = 100

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

        guard let preview = link.preview else {
            return nil
        }

        guard !preview.images.isEmpty else {
            return nil
        }

        if !preview.images[0].resolutions.isEmpty {
            url = preview.images[0].resolutions[preview.images[0].resolutions.count - 1].url
        } else {
            url = nil
        }
        
        return url
    }

    var postHint: PostHint {
        return link.postHint
    }

    private var link: Link

    init(link: Link) {
        self.link = link
    }

    // TODO: This is just returning the preview image height, not the cell height
    func cellHeight(for width: Double) -> Double {
        var previewHeight: Double = 0

        guard let preview = link.preview else { return 0 }
        
        if !preview.images.isEmpty, preview.enabled {
            // Find the most apprioriate width
            var didFindApporiateWidth = false
            
            for i in preview.images[0].resolutions where i.width < width {
                previewHeight = i.height * (width / i.width)
                didFindApporiateWidth = true
            }
            
            // If no appropriate width was been found given a frame width, the just use the minimum image height
            if !didFindApporiateWidth {
                previewHeight = LinkCellViewModel.minimumCellHeight
            }

        } else { 
            previewHeight = LinkCellViewModel.minimumCellHeight
        }

        return previewHeight
    }
}
