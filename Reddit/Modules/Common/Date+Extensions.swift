//
//  NSDate+Extensions.swift
//  Reddit
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import Foundation

public extension Date {
	public init(timeInterval: UInt64) {
		let interval = Double(timeInterval)
		self.init(timeIntervalSince1970: interval)
	}

	public static func timeIntervalString(fromDate: Date, toDate: Date) -> String? {
		if fromDate > toDate {
			return nil
		}

		let calendar = Calendar(identifier: .gregorian)

		let sortedComponents: [Calendar.Component] = [.year, .month, .weekOfYear, .day, .hour, .minute, .second]

		let calendarComponents =
			Set<Calendar.Component>(sortedComponents)

		let components = calendar.dateComponents(calendarComponents,
			from: fromDate,
			to: toDate
		)

		var timeValue: Int = 0
		var intervalComponent: Calendar.Component?

		for component in sortedComponents {
			if let value = components.value(for: component), value > 0 {
				timeValue = value
				intervalComponent = component
				break
			}
		}

		if let component = intervalComponent,
		   let suffix =  Date.suffix(forComponent: component) {
			return "\(timeValue)\(suffix)"
		} else {
			return nil
		}
	}

	public static func suffix(forComponent component: Calendar.Component) -> String? {
		var suffix: String?

		switch component {
			case .second:
				suffix = "s"
			case .minute:
				suffix = "m"
			case .hour:
				suffix = "h"
			case .day:
				suffix = "d"
			case .weekOfYear:
				suffix = "w"
			case .month:
				suffix = "mon"
			case .year:
				suffix = "yr"
			default:
				break
		}

		return suffix
	}
}
