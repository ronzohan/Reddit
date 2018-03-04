//
//  SubredditPresenter.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 2/20/18.
//  Copyright © 2018 Ron Daryl Magno. All rights reserved.
//

import Foundation
import RIBs

class LinkViewPresenter {
    static let minimumCellHeight: Double = 180 
    
    // MARK: - Link View Presentation Logic
    /// Updates the given link view with its associated link
    static func update(titleLinkView: LinkViewable, with link: Link) {
        titleLinkView.setTitle(withTitle: link.title)
        
        let linkMeta = meta(for: link)
        titleLinkView.setMeta(withMeta: linkMeta)
        
        let ups = upsString(for: link)
        titleLinkView.setUps(withUps: ups)
    }
    
    /// Updates the given image link view with its associated link
    static func update(imageLinkView: ImageLinkViewable, with link: Link) {
        guard let imageUrl = imageUrl(for: link) else {
            return
        }

        imageLinkView.setImage(withUrl: imageUrl)
        
        update(titleLinkView: imageLinkView, with: link)

        let height = contentHeight(forWidth: imageLinkView.width, link: link)
        imageLinkView.setContentHeight(height: height)
    }
    
    /// Updates the url link view with its associated link
    static func update(urlLinkView: UrlLinkViewable, with link: Link) {
        if let thumbnailUrl = link.thumbnail {
            urlLinkView.setImage(withUrl: thumbnailUrl)
        }

        update(titleLinkView: urlLinkView, with: link)
    }
    
    /// Returns the appropriate meta data text based off the link
    static func meta(for link: Link) -> String {
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
    
    /// Returns the image url from the link
    static func imageUrl(for link: Link) -> String? {
        guard let preview = link.preview, !preview.images.isEmpty,
            !preview.images[0].resolutions.isEmpty else {
            return nil
        }
        
        return preview.images[0].resolutions[preview.images[0].resolutions.count - 1].url
    }

    /// Returns the content height of the link
    static func contentHeight(forWidth width: Double, link: Link) -> Double {
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
                previewHeight = LinkViewPresenter.minimumCellHeight
            }
            
        } else {
            previewHeight = LinkViewPresenter.minimumCellHeight
        }
        
        return previewHeight
    }
    
    static func upsString(for link: Link) -> String {
        if link.ups > 100000 {
            return "\(link.ups / 10000)k"
        }
         
        switch link.ups {
        case let ups where ups > 100000:
            return "\(link.ups / 10000)k" 
        case let ups where ups >= 1000:
            return "\(link.ups / 1000)k"
        default:
            return "\(link.ups)"
        }
    }
    
    static func postHint(for link: Link) -> PostHint? {
        return link.postHint
    }
} 
