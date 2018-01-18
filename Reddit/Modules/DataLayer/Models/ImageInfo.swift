//
//  ImageInfo.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct ImageInfo: Codable {
    var url: String
    var width: Double
    var height: Double
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        width = try container.decode(Double.self, forKey: .width)
        height = try container.decode(Double.self, forKey: .height)
    }
}
