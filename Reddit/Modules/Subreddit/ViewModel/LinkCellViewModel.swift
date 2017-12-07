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
        guard !link.preview.images.isEmpty else {
            return nil
        }

        if !link.preview.images[0].resolutions.isEmpty {
            return link.preview.images[0].resolutions[link.preview.images[0].resolutions.count - 1].url
        } else {
            return nil
        }
    }

    var postHint: PostHint {
        return link.postHint
    }

    private var link: Link

    init(link: Link) {
        self.link = link
    }

    func getCellHeight(withWidth width: Double) -> Double {
        if !link.preview.images.isEmpty {
            var previewHeight: Double = 0

            for i in link.preview.images[0].resolutions where i.width < width {
                let widthMultiplier = width / i.width
                previewHeight = i.height * Double(widthMultiplier)
            }

            let height: Double

            if link.preview.enabled {
                height = previewHeight
            } else {
                height = 100
            }

            return height
        } else {
            return 0
        }
    }
}
