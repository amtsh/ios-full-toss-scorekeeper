//
//  MatchSummary.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct MatchSummaryUi: View {

  @Binding var match: Match

  var body: some View {
    VStack {
      Text("Match Summary of")
      Text("\(match.firstTeam.teamName)")
      Text("\(match.secondTeam.teamName)")
    }
    .navigationTitle("Match Summary")
  }
}

struct MatchSummaryUi_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      MatchSummaryUi(match: .constant(Match.sampleMatch))
    }
  }
}

