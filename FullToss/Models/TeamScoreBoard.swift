//
//  NewTeamScoreBoard.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-06-16.
//

import Foundation
import SwiftData

enum NewTeamScoreBoardAction {
  case ADDRUNS(_ runs: Int)
  case WICKETDOWN
  case WIDEBALL
  case NOBALL
  case BYE
  case ENDINNINGS
  case UNDO
  case REDO
}

@Model
final class OverDetails {
  var runsInCurrentOver: Int
  var thisOver: [String]

  init(runsInCurrentOver: Int = 0) {
    self.runsInCurrentOver = runsInCurrentOver
    self.thisOver = []
  }
}

@Model
final class Extras {
  var enabled: Bool
  var noBalls: Int
  var wideBalls: Int

  init(enabled: Bool) {
    self.enabled = enabled
    self.noBalls = 0
    self.wideBalls = 0
  }
}

@Model
final class TeamScoreBoard {
  var teamName: String
  var matchOvers: Int
  private(set) var runs: Int = 0
  private(set) var oversDelivered: Int = 0
  private(set) var ballsDelivered: Int = 0
  private(set) var wicketsDown: Int = 0
  private(set) var currentRunRate: Float = 0

  @Relationship(deleteRule: .cascade) var overDetails: OverDetails
  @Relationship(deleteRule: .cascade) var extras: Extras

  var hasInningsEnded: Bool = false

  private var maxHistorySize = 6
  var stateHistory: [TeamScoreBoard] = []

  var ballsLeftInCurrentOver: Int {
    return 6 - ballsDelivered
  }

  var projectedRuns: Int {
    return Int(currentRunRate * Float(matchOvers))
  }

  var totalBallsDeliveredFromStart: Int {
    return (oversDelivered * 6) + ballsDelivered
  }

  var ballsRemainingInMatch: Int {
    return (matchOvers * 6) - totalBallsDeliveredFromStart
  }

  var canUndo: Bool {
    return stateHistory.count > 0
  }

  var canRedo: Bool {
    return false
    // TODO:
    // return stateHistory.count < maxHistorySize
  }

  init(teamName: String, matchOvers: Int, extrasEnabled: Bool) {
    self.teamName = teamName
    self.matchOvers = matchOvers
    self.overDetails = OverDetails()
    self.extras = Extras(enabled: extrasEnabled)
  }

  func act(_ action: NewTeamScoreBoardAction) {
//    let currentState = self

    switch action {
      case .ADDRUNS(let runs):
        updateScoreBoardOnValidDelivery(runs)
        overDetails.thisOver.append("\(runs)")
//        stateHistory.append(currentState)

      case .WICKETDOWN:
        updateScoreBoardOnValidDelivery(0)
        updateWicketsDown()
        overDetails.thisOver.append("W")
//        stateHistory.append(currentState)

      case .NOBALL:
        if ballsDelivered == 0 && isLatestBallValid() {
          resetValuesOnOverStart()
        }
        updateNoBalls()
        overDetails.thisOver.append("NB")
//        stateHistory.append(currentState)

      case .WIDEBALL:
        if ballsDelivered == 0 && isLatestBallValid() {
          resetValuesOnOverStart()
        }
        updateWideBalls()
        overDetails.thisOver.append("WB")
//        stateHistory.append(currentState)

      case .BYE:
        updateRuns(1)
        overDetails.thisOver.append("B")
//        stateHistory.append(currentState)

      case .ENDINNINGS:
        self.endOfInnings()

      case .UNDO:
        if canUndo, let previousState = stateHistory.popLast() {
//          restoreState(previousState)
        }

      case .REDO:
        if canRedo, let nextState = stateHistory.popLast() {
//          restoreState(nextState)
        }
    }
  }

  private func updateScoreBoardOnValidDelivery(_ newRuns: Int) {
    ballsDelivered += 1

    switch ballsDelivered {
      case 1:
        if isLatestBallValid() {
          resetValuesOnOverStart()
        }
      case 6:
        resetValuesOnOverEnd()
      default:
        break
    }

    updateRuns(newRuns)
  }

  private func updateRuns(_ newRuns: Int) {
    runs += newRuns
    updateThisOverRuns(newRuns)
    updateRunRate()
  }

  private func updateRunRate() {
    if totalBallsDeliveredFromStart > 0 {
      currentRunRate = Float(runs) / (Float(totalBallsDeliveredFromStart) / 6.0)
    }
  }

  private func updateThisOverRuns(_ newRuns: Int) {
    overDetails.runsInCurrentOver += newRuns
  }

  private func updateWicketsDown() {
    wicketsDown += 1
  }

  private func updateWideBalls() {
    extras.wideBalls += 1
    if extras.enabled {
      updateRuns(1)
    }
  }

  private func updateNoBalls() {
    extras.noBalls += 1
    if extras.enabled {
      updateRuns(1)
    }
  }

  private func endOfInnings() {
    hasInningsEnded = true
  }

  private func resetValuesOnOverStart() {
    overDetails.runsInCurrentOver = 0
    overDetails.thisOver = []
  }

  private func resetValuesOnOverEnd() {
    oversDelivered += 1
    ballsDelivered = 0

    if oversDelivered == matchOvers {
      endOfInnings()
    }
  }

  private func isLatestBallValid() -> Bool {
    return !["NB", "WB"].contains(overDetails.thisOver.last)
  }
}

