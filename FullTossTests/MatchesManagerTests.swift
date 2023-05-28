//
//  MatchesManagerTests.swift
//  FullTossTests
//
//  Created by Amit Shinde on 2023-05-26.
//

import XCTest
@testable import FullToss

class MatchesManagerTests: XCTestCase {
  var matchesManager: MatchesManager!

  @MainActor override func setUp() {
    super.setUp()
    matchesManager = MatchesManager()
  }

  override func tearDown() {
    matchesManager = nil
    super.tearDown()
  }

  @MainActor func testCreateMatch() {
    // Given
    let match = Match(
      firstTeam: TeamScoreBoard(teamName: "TEAM A", matchOvers: 10),
      secondTeam: TeamScoreBoard(teamName: "TEAM B", matchOvers: 10)
    )

    // When
    matchesManager.createMatch(match: match)

    // Then
    XCTAssertEqual(matchesManager.matches.count, 1)
//    XCTAssertEqual(matchesManager.matches.first, match)
  }

  @MainActor func testDeleteMatch() {
    // Given
    let match1 = Match.sampleMatch
    let match2 = Match.sampleMatch
    let match3 = Match.sampleMatch
    matchesManager.matches = [match1, match2, match3]

    // When
    matchesManager.deleteMatch(match2)

    // Then
    XCTAssertEqual(matchesManager.matches.count, 2)
  }
}

