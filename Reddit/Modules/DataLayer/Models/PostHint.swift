//
//  PostHint.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/24/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

/*
 Currently one of:
 * self
 * video (a video file, like an mp4)
 * image (an image file, like a gif or png)
 * rich:video (a video embedded in HTML - like youtube or vimeo)
 * link (catch-all)
 */
public enum PostHint: String, Codable {
    case redditSelf = "self"
    case video
    case image
    case richVideo = "rich:video"
    case link
}
