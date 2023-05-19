//
//  TeamScoreBoard.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

// Initial state
struct TeamScoreBoard {
  var teamName: String
  var matchOvers: Int
  var runs: Int = 0
  var oversDelivered: Int = 0
  var ballsDelivered: Int = 0
  var wicketsDown: Int = 0
  var currentRunRate: Float = 0
  var projectedRuns: Int = 0
  
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

  var overDetails: OverDetails = OverDetails()
  var extras: Extras = Extras()

  var hasInningsEnded: Bool = false
  // Other necessary properties
}

