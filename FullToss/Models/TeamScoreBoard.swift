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
struct TeamScoreBoard {
  var teamName: String
  var matchOvers: Int
  private(set) var runs: Int = 0
  private(set) var oversDelivered: Int = 0
  private(set) var ballsDelivered: Int = 0
  private(set) var wicketsDown: Int = 0
  private(set) var currentRunRate: Float = 0
  
  struct OverDetails {
    var ballsLeftInCurrentOver: Int = 6
    var runsInCurrentOver = 0
    var thisOver: [String] = []
  }

  struct Extras {
    var enabled: Bool = true
    var noBalls: Int = 0
    var wideBalls: Int = 0
  }

  private(set) var overDetails: OverDetails = OverDetails()
   var extras: Extras = Extras()

  var hasInningsEnded: Bool = false

  // Other necessary properties

  // computed
   var projectedRuns: Int {
    return Int(currentRunRate * Float(matchOvers))
  }

  mutating func act(_ action: TeamScoreBoardAction) {
    switch action {
      case .ADDRUNS(let runs):
        self.updateScoreBoardOnValidDelivery(runs)
        overDetails.thisOver.append("\(runs)")

      case .WICKETDOWN:
        updateScoreBoardOnValidDelivery(0)
        updateWicketsDown()
        overDetails.thisOver.append("W")

      case .NOBALL:
        updateNoBalls()
        overDetails.thisOver.append("NB")

      case .WIDEBALL:
        updateWideBalls()
        overDetails.thisOver.append("WB")

      case .ENDINNINGS:
        self.endOfInnings()

      case .UNDO: break

      case .REDO: break

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
    overDetails.runsInCurrentOver += newRuns
  }

  mutating private func updateRuns(_ newRuns: Int) {
    runs += newRuns

    self.updateRunRate()
  }

  mutating private func updateRunRate() {
    let totalBallsDeliveredFromStart = (oversDelivered * 6) + ballsDelivered
    if (totalBallsDeliveredFromStart > 0) {
      currentRunRate = Float(runs) / (Float(totalBallsDeliveredFromStart) / 6.0)
    }
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

