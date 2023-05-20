//
//  MatchesViewModel.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

class MatchesManager: ObservableObject {
  @Published var matchesList: [Match]

  init() {
    self.matchesList = []
  }

  func createMatch(match: Match) {
    self.matchesList.append(match)
  }
}
