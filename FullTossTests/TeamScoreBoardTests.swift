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
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    XCTAssertEqual(testTeam.runs, 0)

    testTeam.act(.ADDRUNS(1))

    XCTAssertEqual(testTeam.runs, 1, "Runs should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 1, "BallsDelivered should be updated to 1")
    XCTAssertEqual(testTeam.currentRunRate, 6.0)
    XCTAssertEqual(testTeam.projectedRuns, 60)

    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["1"])

    testTeam.act(.ADDRUNS(6))

    XCTAssertEqual(testTeam.runs, 7)
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 7)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["1", "6"])
  }

  func testWicketDown() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    testTeam.act(.WICKETDOWN)
    XCTAssertEqual(testTeam.wicketsDown, 1, "WicketsDown should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 1, "BallsDelivered should be updated to 1")
    XCTAssertEqual(testTeam.overDetails.thisOver, ["W"])

    testTeam.act(.WICKETDOWN)
    XCTAssertEqual(testTeam.wicketsDown, 2, "WicketsDown should be updated to 2")
    XCTAssertEqual(testTeam.ballsDelivered, 2, "BallsDelivered should be updated to 2")
    XCTAssertEqual(testTeam.overDetails.thisOver, ["W", "W"])

    testTeam.act(.UNDO)

    XCTAssertEqual(testTeam.wicketsDown, 1, "WicketsDown should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 1, "BallsDelivered should be updated to 1")
    XCTAssertEqual(testTeam.overDetails.thisOver, ["W"])
  }

  func testWideBall() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    testTeam.act(.WIDEBALL)
    XCTAssertEqual(testTeam.extras.wideBalls, 1, "Wideballs should be updated to 1")
    XCTAssertEqual(testTeam.runs, 1, "Runs should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 0, "BallsDelivered should be updated to 0")
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["WB"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 1)

    testTeam.act(.ADDRUNS(1))
    XCTAssertEqual(testTeam.runs, 2)
    XCTAssertEqual(testTeam.ballsDelivered, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)

    XCTAssertEqual(testTeam.overDetails.thisOver, ["WB", "1"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 2)

    testTeam.act(.UNDO)
    testTeam.act(.UNDO)

    XCTAssertEqual(testTeam.extras.wideBalls, 0)
    XCTAssertEqual(testTeam.runs, 0)
    XCTAssertEqual(testTeam.ballsDelivered, 0)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
    XCTAssertEqual(testTeam.overDetails.thisOver, [])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 0)
  }

  func testNoBall() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    testTeam.act(.NOBALL)
    XCTAssertEqual(testTeam.extras.noBalls, 1)
    XCTAssertEqual(testTeam.extras.wideBalls, 0)
    XCTAssertEqual(testTeam.runs, 1, "Runs should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 0)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["NB"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 1)

    testTeam.act(.ADDRUNS(1))
    XCTAssertEqual(testTeam.runs, 2)
    XCTAssertEqual(testTeam.ballsDelivered, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)

    XCTAssertEqual(testTeam.overDetails.thisOver, ["NB", "1"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 2)

    testTeam.act(.UNDO)
    testTeam.act(.UNDO)

    XCTAssertEqual(testTeam.extras.noBalls, 0)
    XCTAssertEqual(testTeam.runs, 0)
    XCTAssertEqual(testTeam.ballsDelivered, 0)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
    XCTAssertEqual(testTeam.overDetails.thisOver, [])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 0)
  }

  func testEndInnings() {
    let testTeam = TeamScoreBoard(teamName: "Team A", matchOvers: 10, extrasEnabled: true)
    XCTAssertFalse(testTeam.hasInningsEnded)

    testTeam.act(.ENDINNINGS)
    XCTAssertTrue(testTeam.hasInningsEnded)

    // Verify that further actions are not allowed or result in the expected behavior
  }

  func testOneOverComplete() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    XCTAssertEqual(testTeam.runs, 0)

    testTeam.act(.ADDRUNS(1))
    testTeam.act(.ADDRUNS(2))
    testTeam.act(.ADDRUNS(3))
    testTeam.act(.ADDRUNS(4))
    testTeam.act(.ADDRUNS(6))
    testTeam.act(.ADDRUNS(0))

    XCTAssertEqual(testTeam.runs, 16)
    XCTAssertEqual(testTeam.ballsDelivered, 0)
    XCTAssertEqual(testTeam.currentRunRate, 16.0)
    XCTAssertEqual(testTeam.projectedRuns, 160)

    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 16)
//    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 0)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["1", "2", "3", "4", "6", "0"])

    testTeam.act(.ADDRUNS(1))
    XCTAssertEqual(testTeam.runs, 17)
    XCTAssertEqual(testTeam.ballsDelivered, 1)
    XCTAssertEqual(testTeam.oversDelivered, 1)
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["1"])
  }

  func testOneInningsComplete() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 1, extrasEnabled: true)
    XCTAssertEqual(testTeam.runs, 0)

    testTeam.act(.ADDRUNS(1))
    testTeam.act(.ADDRUNS(2))
    testTeam.act(.ADDRUNS(3))
    testTeam.act(.ADDRUNS(4))
    testTeam.act(.ADDRUNS(6))
    testTeam.act(.ADDRUNS(0))

    XCTAssertTrue(testTeam.hasInningsEnded)
  }

  func testUndo() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    testTeam.act(.ADDRUNS(1))

    testTeam.act(.UNDO)

    XCTAssertEqual(testTeam.runs, 0, "Runs should be reset to 0 after undo")
  }

  func skip_testRedo() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)
    testTeam.act(.ADDRUNS(6))

    testTeam.act(.UNDO)
    testTeam.act(.REDO)

    XCTAssertEqual(testTeam.runs, 6, "Runs should be reset to 0 after redo")
  }

  func testExtrasDisabled() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: false)
      testTeam.act(.NOBALL)
      XCTAssertEqual(testTeam.extras.noBalls, 1)
      XCTAssertEqual(testTeam.extras.wideBalls, 0)
      XCTAssertEqual(testTeam.runs, 0)
      XCTAssertEqual(testTeam.ballsDelivered, 0)
      XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
      XCTAssertEqual(testTeam.overDetails.thisOver, ["NB"])
      XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 0)

      testTeam.act(.WIDEBALL)
      XCTAssertEqual(testTeam.extras.noBalls, 1)
      XCTAssertEqual(testTeam.extras.wideBalls, 1)
      XCTAssertEqual(testTeam.runs, 0)
      XCTAssertEqual(testTeam.ballsDelivered, 0)
      XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
      XCTAssertEqual(testTeam.overDetails.thisOver, ["NB", "WB"])
      XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 0)

      testTeam.act(.ADDRUNS(1))
      XCTAssertEqual(testTeam.runs, 1)
      XCTAssertEqual(testTeam.ballsDelivered, 1)
      XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)

      XCTAssertEqual(testTeam.overDetails.thisOver, ["NB", "WB", "1"])
      XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 1)
  }

  func testConsecutiveExtras() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)

    testTeam.act(.NOBALL)
    XCTAssertEqual(testTeam.extras.noBalls, 1)
    XCTAssertEqual(testTeam.extras.wideBalls, 0)
    XCTAssertEqual(testTeam.runs, 1, "Runs should be updated to 1")
    XCTAssertEqual(testTeam.ballsDelivered, 0)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["NB"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 1)

    testTeam.act(.WIDEBALL)
    XCTAssertEqual(testTeam.extras.noBalls, 1)
    XCTAssertEqual(testTeam.extras.wideBalls, 1)
    XCTAssertEqual(testTeam.runs, 2)
    XCTAssertEqual(testTeam.ballsDelivered, 0)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 6)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["NB", "WB"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 2)

    testTeam.act(.ADDRUNS(1))
    XCTAssertEqual(testTeam.runs, 3)
    XCTAssertEqual(testTeam.ballsDelivered, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)

    XCTAssertEqual(testTeam.overDetails.thisOver, ["NB", "WB", "1"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 3)
  }

  func testConsecutiveExtrasVariant1() {
    let testTeam = TeamScoreBoard(teamName: "Test team", matchOvers: 10, extrasEnabled: true)

    testTeam.act(.ADDRUNS(1))
    XCTAssertEqual(testTeam.runs, 1)
    XCTAssertEqual(testTeam.ballsDelivered, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)

    testTeam.act(.NOBALL)
    XCTAssertEqual(testTeam.extras.noBalls, 1)
    XCTAssertEqual(testTeam.extras.wideBalls, 0)
    XCTAssertEqual(testTeam.runs, 2)
    XCTAssertEqual(testTeam.ballsDelivered, 1)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 5)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["1", "NB"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 2)

    testTeam.act(.ADDRUNS(1))
    XCTAssertEqual(testTeam.runs, 3)
    XCTAssertEqual(testTeam.ballsDelivered, 2)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 4)

    testTeam.act(.WIDEBALL)
    XCTAssertEqual(testTeam.extras.noBalls, 1)
    XCTAssertEqual(testTeam.extras.wideBalls, 1)
    XCTAssertEqual(testTeam.runs, 4)
    XCTAssertEqual(testTeam.ballsDelivered, 2)
    XCTAssertEqual(testTeam.ballsLeftInCurrentOver, 4)
    XCTAssertEqual(testTeam.overDetails.thisOver, ["1", "NB", "1", "WB"])
    XCTAssertEqual(testTeam.overDetails.runsInCurrentOver, 4)
  }

  // Add more tests for other actions if needed

}

