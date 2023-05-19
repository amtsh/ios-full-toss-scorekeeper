//
//  ScoreBoardViewModelTests.swift
//  FullTossTests
//
//  Created by Amit Shinde on 2023-05-17.
//

import XCTest
@testable import FullToss

class ScoreBoardViewModelTests: XCTestCase {

  func testAddRuns() {
    let viewModel = TeamScoreBoardViewModel("Test team", matchOvers: 10)
    viewModel.reduce(action: .ADDRUNS(runs: 5))

    XCTAssertEqual(viewModel.scoreBoard.runs, 5, "Runs should be updated to 5")
    XCTAssertEqual(viewModel.scoreBoard.ballsDelivered, 1, "BallsDelivered should be updated to 1")
  }

  func testWicketDown() {
    let viewModel = TeamScoreBoardViewModel("Test team", matchOvers: 10)
    viewModel.reduce(action: .WICKETDOWN)

    XCTAssertEqual(viewModel.scoreBoard.wicketsDown, 1, "WicketsDown should be updated to 1")
    XCTAssertEqual(viewModel.scoreBoard.ballsDelivered, 1, "BallsDelivered should be updated to 1")
  }

  func skip_testUndo() {
    let viewModel = TeamScoreBoardViewModel("Test team", matchOvers: 10)
    viewModel.reduce(action: .ADDRUNS(runs: 5))

    viewModel.undo()

    XCTAssertEqual(viewModel.scoreBoard.runs, 0, "Runs should be reset to 0 after undo")
  }

  func skip_testRedo() {
    let viewModel = TeamScoreBoardViewModel("Test team", matchOvers: 10)
    viewModel.reduce(action: .ADDRUNS(runs: 5))

    viewModel.undo()
    viewModel.redo()

    XCTAssertEqual(viewModel.scoreBoard.runs, 5, "Runs should be restored to 5 after redo")
  }

  // Add more tests for other actions if needed

}

