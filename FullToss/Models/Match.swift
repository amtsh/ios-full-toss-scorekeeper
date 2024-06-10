//
//  Match.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import Foundation
import SwiftData

@Model
final class Match {
  var id: UUID
  var matchTimestamp: Int
  @Relationship(deleteRule: .cascade) var firstTeam: TeamScoreBoard
  @Relationship(deleteRule: .cascade) var secondTeam: TeamScoreBoard

  init(id: UUID = UUID(), firstTeam: TeamScoreBoard, secondTeam: TeamScoreBoard) {
    self.id = id
    self.firstTeam = firstTeam
    self.secondTeam = secondTeam
    self.matchTimestamp = getEpochTime()
  }
}

extension Match {
  static var sampleMatch = Match(
    firstTeam: TeamScoreBoard(teamName: "TEAM A", matchOvers: 10, extrasEnabled: true),
    secondTeam: TeamScoreBoard(teamName: "TEAM B", matchOvers: 10, extrasEnabled: true)
  )

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
