//
//  Match.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct Match: Identifiable {
  var id: UUID
  var firstTeam: TeamScoreBoard
  var secondTeam: TeamScoreBoard
  var matchDate: String = ""

  init(id: UUID = UUID(), firstTeam: TeamScoreBoard, secondTeam: TeamScoreBoard) {
    self.id = id
    self.firstTeam = firstTeam
    self.secondTeam = secondTeam
    self.matchDate = getCurrentDate()
  }

  // computed
  var runsToWin: Int {
    return firstTeam.runs - secondTeam.runs
  }

  // computed
  var isMatchEnded: Bool {
    if firstTeam.hasInningsEnded && secondTeam.hasInningsEnded {
      return true
    }

    return false
  }

  // computed
  var winner: String {
    if isMatchEnded {
      if firstTeam.runs < secondTeam.runs {
        return secondTeam.teamName
      }
      if firstTeam.runs > secondTeam.runs {
        return firstTeam.teamName
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
    firstTeam: TeamScoreBoard(teamName: "TEAM A", matchOvers: 10),
    secondTeam: TeamScoreBoard(teamName: "TEAM B", matchOvers: 10)
  )
}
