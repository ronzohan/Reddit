//
//  UIKitExtensions.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 10/31/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
	static var reuseIdentifier: String { get }
}

extension ReusableView {
	static var reuseIdentifier: String {
		return String(describing: self)
	}
}

extension UITableViewCell: ReusableView {
}

extension UITableView {
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T? {
		guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
			debugPrint("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
			return nil
		}

		return cell
	}
}
