//
//  Image.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct Image: Codable {
    let source: ImageInfo
    let resolutions: [ImageInfo]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case source
        case resolutions
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        source = try container.decode(ImageInfo.self, forKey: CodingKeys.source)
        resolutions = try container.decode([ImageInfo].self, forKey: .resolutions)
        id = try container.decode(String.self, forKey: .id)
    }
}
