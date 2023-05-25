//
//  utilsTests.swift
//  FullTossTests
//
//  Created by Amit Shinde on 2023-05-25.
//

import XCTest
@testable import FullToss

class UtilsTests: XCTestCase {

  func testGetLocalTimeString() {
    let epochTime = 1621603200 // May 22, 2021 00:00:00 UTC
    let expectedString = "Fri, May 21, 03:20 PM"
    let result = getLocalTimeString(epochTime)
    XCTAssertEqual(result, expectedString)

    let epochTime2 = 1667510400 // March 5, 2023 12:00:00 UTC
    let expectedString2 = "Thu, Nov 3, 10:20 PM"
    let result2 = getLocalTimeString(epochTime2)
    XCTAssertEqual(result2, expectedString2)

    // Add more test cases as needed
  }

}
