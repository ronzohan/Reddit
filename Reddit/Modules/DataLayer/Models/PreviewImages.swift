//
//  PreviewImages.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/20/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

struct PreviewImage: Codable {
    var images: [Image]
    var enabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case images
        case enabled
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        images = try container.decode([Image].self, forKey: .images)
        enabled = try container.decode(Bool.self, forKey: .enabled)
    }
}
