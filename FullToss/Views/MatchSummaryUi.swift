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
      Divider()
      VStack {
        MainScore(
          teamName: match.firstTeam.teamName,
          matchOvers: match.firstTeam.matchOvers,
          totalRuns: match.firstTeam.runs,
          totalWicketsDown: match.firstTeam.wicketsDown,
          oversDelivered: match.firstTeam.oversDelivered,
          ballsDelivered: match.firstTeam.ballsDelivered
        )
        BattingExtraStats(
          currentRunRate: match.firstTeam.currentRunRate,
          wideBalls: match.firstTeam.extras.wideBalls,
          noBalls: match.firstTeam.extras.noBalls
        )
      }

      Divider()
      ToWinInfo(match: match).padding(.vertical)
      Divider()
      
      VStack {
        MainScore(
          teamName: match.secondTeam.teamName,
          matchOvers: match.secondTeam.matchOvers,
          totalRuns: match.secondTeam.runs,
          totalWicketsDown: match.secondTeam.wicketsDown,
          oversDelivered: match.secondTeam.oversDelivered,
          ballsDelivered: match.secondTeam.ballsDelivered
        )
        BattingExtraStats(
          currentRunRate: match.secondTeam.currentRunRate,
          wideBalls: match.secondTeam.extras.wideBalls,
          noBalls: match.secondTeam.extras.noBalls
        )
      }
      Divider()
      Spacer()
    }
    .navigationTitle("Match Summary")
    .navigationBarTitleDisplayMode(.large)
  }
}

struct MatchSummaryUi_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      MatchSummaryUi(match: Match.sampleMatch)
    }
  }
}

