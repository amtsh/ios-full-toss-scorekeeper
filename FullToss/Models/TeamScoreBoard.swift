//
//  TeamScoreBoard.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

enum TeamScoreBoardAction {
  case ADDRUNS(_ runs: Int)
  case WICKETDOWN
  case WIDEBALL
  case NOBALL
  case ENDINNINGS
  case UNDO
  case REDO
}

// Initial state
struct TeamScoreBoard: Codable {
  var teamName: String
  var matchOvers: Int
  private(set) var runs: Int = 0
  private(set) var oversDelivered: Int = 0
  private(set) var ballsDelivered: Int = 0
  private(set) var wicketsDown: Int = 0
  private(set) var currentRunRate: Float = 0
  
  struct OverDetails: Codable {
    var ballsLeftInCurrentOver: Int = 6
    var runsInCurrentOver = 0
    var thisOver: [String] = []
  }

  struct Extras: Codable {
    var enabled: Bool = true
    var noBalls: Int = 0
    var wideBalls: Int = 0
  }

  private(set) var overDetails: OverDetails = OverDetails()
  var extras: Extras = Extras()

  var hasInningsEnded: Bool = false

  // State history
  private var maxHistorySize = 6
  var stateHistory: [TeamScoreBoard] = []

  // Other necessary properties

  init(teamName: String, matchOvers: Int) {
    self.teamName = teamName
    self.matchOvers = matchOvers
  }

  // computed
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
//    TODO:
//    return stateHistory.count < maxHistorySize
  }

  mutating func act(_ action: TeamScoreBoardAction) {
    // Store the current state before it is modified
    let currentState = self

    switch action {
      case .ADDRUNS(let runs):
        self.updateScoreBoardOnValidDelivery(runs)
        overDetails.thisOver.append("\(runs)")

        stateHistory.append(currentState)

      case .WICKETDOWN:
        updateScoreBoardOnValidDelivery(0)
        updateWicketsDown()
        overDetails.thisOver.append("W")

        stateHistory.append(currentState)

      case .NOBALL:
        updateNoBalls()
        overDetails.thisOver.append("NB")

        stateHistory.append(currentState)

      case .WIDEBALL:
        updateWideBalls()
        overDetails.thisOver.append("WB")

        stateHistory.append(currentState)

      case .ENDINNINGS:
        self.endOfInnings()


      case .UNDO:
        // Undo the last action by restoring the previous state
        if canUndo {
          if let previousState = stateHistory.popLast() {
            self = previousState
          }
        }

      case .REDO:
        // Redo the last undone action by restoring the next state
        if canRedo {
          if let nextState = stateHistory.popLast() {
            self = nextState
          }
        }
    }
  }

  mutating private func updateScoreBoardOnValidDelivery(_ newRuns: Int) {
    ballsDelivered += 1
    overDetails.ballsLeftInCurrentOver = 6 - ballsDelivered

    switch ballsDelivered {
      case 1:
        self.resetValuesOnOverStart()
      case 6:
        self.resetValuesOnOverEnd()
      default:
        break
    }

    self.updateRuns(newRuns)
  }

  mutating private func updateRuns(_ newRuns: Int) {
    runs += newRuns

    self.updateThisOverRuns(newRuns)
    self.updateRunRate()
  }

  mutating private func updateRunRate() {
    if (totalBallsDeliveredFromStart > 0) {
      currentRunRate = Float(runs) / (Float(totalBallsDeliveredFromStart) / 6.0)
    }
  }

  mutating private func updateThisOverRuns(_ newRuns: Int) {
    overDetails.runsInCurrentOver += newRuns
  }

  mutating private func updateWicketsDown() {
    wicketsDown += 1
  }

  mutating private func updateWideBalls() {
    extras.wideBalls += 1
    if(extras.enabled) {
      self.updateRuns(1)
    }
  }

  mutating private func updateNoBalls() {
    extras.noBalls += 1
    if(extras.enabled) {
      self.updateRuns(1)
    }
  }

  mutating private func endOfInnings() {
    hasInningsEnded = true
  }

  mutating private func resetValuesOnOverStart() {
    overDetails.runsInCurrentOver = 0
    overDetails.thisOver = []
  }

  mutating private func resetValuesOnOverEnd() {
    oversDelivered += 1
    ballsDelivered = 0

    if oversDelivered == matchOvers {
      self.endOfInnings()
    }
  }
}

