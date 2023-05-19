//
//  Match.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct Match: Identifiable {
  var id = UUID()
  var firstTeam: TeamScoreBoardViewModel
  var secondTeam: TeamScoreBoardViewModel

  struct CommonInfo {
    var matchDate: String = getCurrentDate()
    var winner = ""
  }

  var commonInfo: CommonInfo // info like who won?
}
