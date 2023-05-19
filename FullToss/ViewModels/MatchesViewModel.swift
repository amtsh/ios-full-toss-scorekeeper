//
//  MatchesViewModel.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

class MatchesViewModel: ObservableObject {
  @Published var matchesList: [Match]

  init() {
    self.matchesList = []
  }

  func addMatch(match: Match) {
    self.matchesList.append(match)
  }
}
