//
//  Match.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct Match: Identifiable, Codable {
  var id: UUID
  var firstTeam: TeamScoreBoard
  var secondTeam: TeamScoreBoard
  var matchTimestamp: Int

  init(id: UUID = UUID(), firstTeam: TeamScoreBoard, secondTeam: TeamScoreBoard) {
    self.id = id
    self.firstTeam = firstTeam
    self.secondTeam = secondTeam
    self.matchTimestamp = getEpochTime()
  }

  // computed
  var runsRemainingToWin: Int {
    return (firstTeam.runs + 1) - secondTeam.runs
  }

  // computed
  var hasSecondTeamWon: Bool {
    return secondTeam.runs >= (firstTeam.runs + 1)
  }

  // computed
  var isMatchEnded: Bool {
    return firstTeam.hasInningsEnded && secondTeam.hasInningsEnded
  }

  // computed
  var winner: String {
    if isMatchEnded {
      if firstTeam.runs < secondTeam.runs {
        return "\(secondTeam.teamName) WON"
      }
      if firstTeam.runs > secondTeam.runs {
        return "\(firstTeam.teamName) WON"
      }
      if firstTeam.runs == secondTeam.runs {
        return "DRAW"
      }
    }
    return ""
  }
}

extension Match {
  static var sampleMatch = Match(
    firstTeam: TeamScoreBoard(teamName: "TEAM A", matchOvers: 10, extrasEnabled: true),
    secondTeam: TeamScoreBoard(teamName: "TEAM B", matchOvers: 10, extrasEnabled: true)
  )
}
