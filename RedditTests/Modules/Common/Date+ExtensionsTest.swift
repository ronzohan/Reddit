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
        let timeEpoch: UInt64 = 1_505_958_257
        let timeEpochDouble: Double = 1_505_958_257

        // When I convert time epoch into date
        let date = Date(timeInterval: timeEpoch)
        let expectedDate = Date(timeIntervalSince1970: timeEpochDouble)

        // Then it should convert correctly
        XCTAssertEqual(date, expectedDate)
    }

    func testTimeDifferenceString() {
        let timeEpoch: TimeInterval = 1_506_008_462
        let toDate = Date(timeIntervalSince1970: timeEpoch)

        let timeEpochSec: TimeInterval = 1_506_008_461
        let fromDateSec = Date(timeIntervalSince1970: timeEpochSec)
        let expectedTimeIntervalStrSec = "1s"
        let strTimeIntervalSec = Date.timeIntervalString(fromDate: fromDateSec, toDate: toDate)
        XCTAssertEqual(strTimeIntervalSec, expectedTimeIntervalStrSec)

        let timeEpochMin: TimeInterval = 1_506_007_682
        let fromDateMin = Date(timeIntervalSince1970: timeEpochMin)
        let expectedTimeIntervalStrMin = "13m"
        let strTimeIntervalMin = Date.timeIntervalString(fromDate: fromDateMin, toDate: toDate)
        XCTAssertEqual(strTimeIntervalMin, expectedTimeIntervalStrMin)

        let timeEpochHr: TimeInterval = 1_505_958_257
        let fromDateHr = Date(timeIntervalSince1970: timeEpochHr)
        let expectedTimeIntervalStrHr = "13h"
        let strTimeIntervalHr = Date.timeIntervalString(fromDate: fromDateHr, toDate: toDate)
        XCTAssertEqual(strTimeIntervalHr, expectedTimeIntervalStrHr)

        let timeEpochDay: TimeInterval = 1_505_834_882
        let fromDateDay = Date(timeIntervalSince1970: timeEpochDay)
        let expectedTimeIntervalStrDay = "2d"
        let strTimeIntervalDay = Date.timeIntervalString(fromDate: fromDateDay, toDate: toDate)
        XCTAssertEqual(strTimeIntervalDay, expectedTimeIntervalStrDay)

        let timeEpochWk: TimeInterval = 1_505_403_108
        let fromDateWk = Date(timeIntervalSince1970: timeEpochWk)
        let expectedTimeIntervalStrWk = "1w"
        let strTimeIntervalWk = Date.timeIntervalString(fromDate: fromDateWk, toDate: toDate)
        XCTAssertEqual(strTimeIntervalWk, expectedTimeIntervalStrWk)

        let timeEpochMonth: TimeInterval = 1_503_243_888
        let fromDateMonth = Date(timeIntervalSince1970: timeEpochMonth)
        let expectedTimeIntervalStrMonth = "1mon"
        let strTimeIntervalMonth = Date.timeIntervalString(fromDate: fromDateMonth, toDate: toDate)
        XCTAssertEqual(strTimeIntervalMonth, expectedTimeIntervalStrMonth)

        let timeEpochYr: TimeInterval = 1_472_688_000
        let fromDateYr = Date(timeIntervalSince1970: timeEpochYr)
        let expectedTimeIntervalStrYr = "1yr"
        let strTimeIntervalYr = Date.timeIntervalString(fromDate: fromDateYr, toDate: toDate)
        XCTAssertEqual(strTimeIntervalYr, expectedTimeIntervalStrYr)
    }

    func testTimeFromDateIsSmallerThanToDate() {
        let timeEpoch: TimeInterval = 1_505_008_462
        let toDate = Date(timeIntervalSince1970: timeEpoch)

        let timeEpochSec: TimeInterval = 1_506_008_463
        let fromDateSec = Date(timeIntervalSince1970: timeEpochSec)
        let strTimeIntervalSec = Date.timeIntervalString(fromDate: fromDateSec, toDate: toDate)
        XCTAssertEqual(strTimeIntervalSec, nil)
    }

    func testSuffixForComponent() {
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.second),
            "s"
        )
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.minute),
            "m"
        )
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.hour),
            "h"
        )
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.day),
            "d"
        )
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.weekOfYear),
            "w"
        )
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.month),
            "mon"
        )
        XCTAssertEqual(
            Date.suffix(forComponent: Calendar.Component.year),
            "yr"
        )

        XCTAssertNil(Date.suffix(forComponent: Calendar.Component.weekdayOrdinal))
    }
}
