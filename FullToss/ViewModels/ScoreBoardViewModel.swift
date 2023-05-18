//
//  TeamAViewModel.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

enum ScoreBoardAction {
  case ADDRUNS(runs: Int)
  case WICKETDOWN
  case WIDEBALL
  case NOBALL
  case UNDO
  case REDO
}

class ScoreBoardViewModel: ObservableObject {
  @Published var scoreBoard: ScoreBoard

  private var undoManager = UndoManager()

  init(_ teamName: String, matchOvers: Int) {
    self.scoreBoard = ScoreBoard(teamName: teamName, matchOvers: matchOvers)
  }

  func reduce(action: ScoreBoardAction) {
    switch action {
      case .ADDRUNS(let runs):
        updateScoreBoardOnValidDelivery(runs)
        scoreBoard.overDetails.thisOver.append("\(runs)")

      case .WICKETDOWN:
        updateScoreBoardOnValidDelivery(0)
        updateWicketsDown()
        scoreBoard.overDetails.thisOver.append("W")

      case .NOBALL:
        updateNoBalls()
        scoreBoard.overDetails.thisOver.append("NB")

      case .WIDEBALL:
        updateWideBalls()
        scoreBoard.overDetails.thisOver.append("WB")

      case .UNDO:
        if undoManager.canUndo {
          undoManager.undo()
        }
      case .REDO:
        if undoManager.canUndo {
          undoManager.redo()
        }
    }
  }

  func undo() {
    reduce(action: .UNDO)
  }

  func redo() {
    reduce(action: .REDO)
  }

  private func updateScoreBoardOnValidDelivery(_ runs: Int) {
    scoreBoard.ballsDelivered += 1
    scoreBoard.overDetails.ballsLeftInCurrentOver = 6 - scoreBoard.ballsDelivered

    switch scoreBoard.ballsDelivered {
      case 1:
        resetValuesOnOverStart()
      case 6:
        resetValuesOnOverEnd()
      default:
        break
    }

    updateRuns(runs)
    scoreBoard.overDetails.runsInCurrentOver += runs
  }

  private func updateRuns(_ runs: Int) {
    scoreBoard.runs += runs
  }

  private func updateWicketsDown() {
    scoreBoard.wicketsDown += 1
  }

  private func updateNoBalls() {
    scoreBoard.extras.noBalls += 1
    if(scoreBoard.extras.enabled) {
      updateRuns(1)
    }

  }

  private func updateWideBalls() {
    scoreBoard.extras.wideBalls += 1
    if(scoreBoard.extras.enabled) {
      updateRuns(1)
    }
  }

  private func resetValuesOnOverStart() {
    scoreBoard.overDetails.runsInCurrentOver = 0
    scoreBoard.overDetails.thisOver = []
  }

  private func resetValuesOnOverEnd() {
    scoreBoard.oversDelivered += 1
    scoreBoard.ballsDelivered = 0
  }
}
