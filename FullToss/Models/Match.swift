//
//  Match.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

enum MatchStatus {
  case inProgress
  case ended
}

struct Match: Identifiable {
  var id: UUID
  var firstTeam: TeamScoreBoard
  var secondTeam: TeamScoreBoard
  var matchStatus: MatchStatus
  var matchDate: String = ""
  var winner = ""

  init(id: UUID = UUID(), firstTeam: TeamScoreBoard, secondTeam: TeamScoreBoard) {
    self.id = id
    self.firstTeam = firstTeam
    self.secondTeam = secondTeam
    self.matchDate = getCurrentDate()
    self.matchStatus = .inProgress
  }
}
