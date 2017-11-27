//
//  Image.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct Image {
    var source: ImageInfo = ImageInfo()
    var resolutions: [ImageInfo] = []
    var id: String = ""
}

extension Image: Decodable {
    enum ImageKeys: String, CodingKey {
        case source
        case resolutions
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        let source = try container.decode(ImageInfo.self, forKey: .source)
        let resolutions = try container.decode([ImageInfo].self, forKey: .resolutions)
        let id = try container.decode(String.self, forKey: .id)
        
        self.init(source: source, resolutions: resolutions, id: id)
    }
}
