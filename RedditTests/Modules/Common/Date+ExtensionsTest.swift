//
//  Date+ExtensionsTest.swift
//  RedditTests
//
//  Created by Ron Daryl Magno on 9/21/17.
//  Copyright © 2017 Ron Daryl Magno. All rights reserved.
//

import XCTest
@testable import Reddit

class Date_ExtensionsTest: XCTestCase {
    func testTimeEpoch() {
		// Given I have a time epoch
		let timeEpoch: UInt64 = 1505958257
		let timeEpochDouble: Double = 1505958257
		
		// When I convert time epoch into date
		let date = Date(timeInterval: timeEpoch)
		let expectedDate = Date(timeIntervalSince1970: timeEpochDouble)
		
		// Then it should convert correctly
		XCTAssertEqual(date, expectedDate)
    }

	func testTimeDifferenceString() {
		let timeEpoch: TimeInterval = 1506008462
		let toDate = Date(timeIntervalSince1970: timeEpoch)
		
		let timeEpochSec: TimeInterval = 1506008461
		let fromDateSec = Date(timeIntervalSince1970: timeEpochSec)
		let expectedTimeIntervalStrSec = "1s"
		let strTimeIntervalSec = Date.timeIntervalString(fromDate: fromDateSec, toDate: toDate)
		XCTAssertEqual(strTimeIntervalSec, expectedTimeIntervalStrSec)
		
		let timeEpochMin: TimeInterval = 1506007682
		let fromDateMin = Date(timeIntervalSince1970: timeEpochMin)
		let expectedTimeIntervalStrMin = "13m"
		let strTimeIntervalMin = Date.timeIntervalString(fromDate: fromDateMin, toDate: toDate)
		XCTAssertEqual(strTimeIntervalMin, expectedTimeIntervalStrMin)
		
		let timeEpochHr: TimeInterval = 1505958257
		let fromDateHr = Date(timeIntervalSince1970: timeEpochHr)
		let expectedTimeIntervalStrHr = "13h"
		let strTimeIntervalHr = Date.timeIntervalString(fromDate: fromDateHr, toDate: toDate)
		XCTAssertEqual(strTimeIntervalHr, expectedTimeIntervalStrHr)
		
		let timeEpochDay: TimeInterval = 1505834882
		let fromDateDay = Date(timeIntervalSince1970: timeEpochDay)
		let expectedTimeIntervalStrDay = "2d"
		let strTimeIntervalDay = Date.timeIntervalString(fromDate: fromDateDay, toDate: toDate)
		XCTAssertEqual(strTimeIntervalDay, expectedTimeIntervalStrDay)
		
		let timeEpochWk: TimeInterval = 1505403108
		let fromDateWk = Date(timeIntervalSince1970: timeEpochWk)
		let expectedTimeIntervalStrWk = "1w"
		let strTimeIntervalWk = Date.timeIntervalString(fromDate: fromDateWk, toDate: toDate)
		XCTAssertEqual(strTimeIntervalWk, expectedTimeIntervalStrWk)
		
		let timeEpochMonth: TimeInterval = 1503243888
		let fromDateMonth = Date(timeIntervalSince1970: timeEpochMonth)
		let expectedTimeIntervalStrMonth = "1mon"
		let strTimeIntervalMonth = Date.timeIntervalString(fromDate: fromDateMonth, toDate: toDate)
		XCTAssertEqual(strTimeIntervalMonth, expectedTimeIntervalStrMonth)
		
		let timeEpochYr: TimeInterval = 1472688000
		let fromDateYr = Date(timeIntervalSince1970: timeEpochYr)
		let expectedTimeIntervalStrYr = "1yr"
		let strTimeIntervalYr = Date.timeIntervalString(fromDate: fromDateYr, toDate: toDate)
		XCTAssertEqual(strTimeIntervalYr, expectedTimeIntervalStrYr)
	}

	func testTimeFromDateIsSmallerThanToDate() {
		let timeEpoch: TimeInterval = 1505008462
		let toDate = Date(timeIntervalSince1970: timeEpoch)
		
		let timeEpochSec: TimeInterval = 1506008463
		let fromDateSec = Date(timeIntervalSince1970: timeEpochSec)
		let strTimeIntervalSec = Date.timeIntervalString(fromDate: fromDateSec, toDate: toDate)
		XCTAssertEqual(strTimeIntervalSec, nil)
	}
	
	func testSuffixForComponent() {
		let component = Calendar.Component.weekdayOrdinal
		
		let suffix = Date.suffix(forComponent: component)
		
		XCTAssertNil(suffix)
	}
}
