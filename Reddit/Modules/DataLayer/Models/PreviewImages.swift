//
//  PreviewImages.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct PreviewImage {
    var images: [Image] = []
    var enabled: Bool = false
}

extension PreviewImage: Decodable {
    enum PreviewImageKeys: String, CodingKey {
        case images
        case enabled
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PreviewImageKeys.self)

        let images = try container.decode([Image].self, forKey: .images)
        let enabled = try container.decode(Bool.self, forKey: .enabled)

        self.init(images: images, enabled: enabled)
    }
}
