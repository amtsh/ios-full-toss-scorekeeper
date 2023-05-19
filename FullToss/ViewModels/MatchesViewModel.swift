//
//  MatchesViewModel.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct Match: Identifiable {
  var id = UUID()
  var firstTeam: ScoreBoardViewModel
  var secondTeam: ScoreBoardViewModel

  struct CommonInfo {
    var matchDate: String = getCurrentDate()
    var winner = ""
  }

  var commonInfo: CommonInfo // info like who won?
}

class MatchesViewModel: ObservableObject {
  @Published var matchesList: [Match]

  init() {
    self.matchesList = []
  }

  func addMatch(match: Match) {
    self.matchesList.append(match)
  }
}
