//
//  RedditEndpoint.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 8/17/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

protocol RedditEndpoint {
	var baseUrl: String { get }
	var version: String? { get }
	var urlLocation: String { get }
	var urlParameters: [String: Any]? { get }

	func url() -> String
}

extension RedditEndpoint {
	var baseUrl: String {
		return "https://www.reddit.com/"
	}

	func url() -> String {
		return "\(baseUrl)/\(urlLocation)/\(urlParameters)"
	}
}
