//
//  ScoreBoardViewModelTests.swift
//  FullTossTests
//
//  Created by Amit Shinde on 2023-05-17.
//

import XCTest
@testable import FullToss

class TeamScoreBoardTests: XCTestCase {

  func testAddRuns() {
    var testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10)
    testTeam.act(.ADDRUNS(5))

    XCTAssertEqual(testTeam.runs, 5, "Runs should be updated to 5")
    XCTAssertEqual(testTeam.ballsDelivered, 1, "BallsDelivered should be updated to 1")
  }

  func testWicketDown() {
    var testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10)
    testTeam.act(.WICKETDOWN)

    XCTAssertEqual(testTeam.wicketsDown, 1, "WicketsDown should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 1, "BallsDelivered should be updated to 1")
  }

  func skip_testUndo() {
    var testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10)
    testTeam.act(.ADDRUNS(5))

    testTeam.act(.UNDO)

    XCTAssertEqual(testTeam.runs, 0, "Runs should be reset to 0 after undo")
  }

  func skip_testRedo() {
    var testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10)
    testTeam.act(.ADDRUNS(5))

    testTeam.act(.UNDO)
    testTeam.act(.REDO)

    XCTAssertEqual(testTeam.runs, 0, "Runs should be reset to 0 after undo")
  }

  // Add more tests for other actions if needed

}

