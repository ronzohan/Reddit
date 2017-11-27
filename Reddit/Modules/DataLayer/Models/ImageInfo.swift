//
//  ImageInfo.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct ImageInfo {
    var url: String = ""
    var width: Double = 0
    var height: Double = 0
}

extension ImageInfo: Decodable {
    enum ImageInfoKeys: String, CodingKey {
        case url
        case width
        case height
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageInfoKeys.self)
        let url: String = try container.decode(String.self, forKey: .url)
        let width = try container.decode(Double.self, forKey: .width)
        let height = try container.decode(Double.self, forKey: .height)
        
        self.init(url: url, width: width, height: height)
    }
}
