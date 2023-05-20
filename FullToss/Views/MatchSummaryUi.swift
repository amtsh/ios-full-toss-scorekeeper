//
//  MatchSummary.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct MatchSummaryUi: View {

  var match: Match

  var body: some View {
    VStack {
      Text("Match Summary of")
      Text("\(match.firstTeam.scoreBoard.teamName)")
      Text("\(match.secondTeam.scoreBoard.teamName)")
    }

  }
}

struct MatchSummaryUi_Previews: PreviewProvider {
  static var previews: some View {
    MatchSummaryUi(
      match: Match(id: UUID(),
                   firstTeam: TeamScoreBoardViewModel("TEAM A", matchOvers: 10),
                   secondTeam: TeamScoreBoardViewModel("TEAM B", matchOvers: 10)
                  )
    )
  }
}

