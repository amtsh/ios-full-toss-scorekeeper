//
//   BattingExtraStats.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct MainScore: View {

  var teamName: String
  var matchOvers: Int
  var totalRuns: Int
  var totalWicketsDown: Int
  var oversDelivered: Int
  var ballsDelivered: Int

  var body: some View {
    HStack() {
      Text("\(teamName)")
        .font(.system(.title2, weight: .bold))
        .foregroundColor(.secondary)
      Spacer()
      Text("\(totalRuns)-\(totalWicketsDown)")
        .frame(maxWidth: .infinity, alignment: .trailing)
        .clipped()
        .font(.system(size: 70, weight: .semibold, design: .default))
    }
    .padding(.top, 0)
    .padding(.horizontal)
    Text("\(oversDelivered).\(ballsDelivered) / \(matchOvers)")
      .frame(maxWidth: .infinity, alignment: .trailing)
      .clipped()
      .padding(.horizontal)
      .font(.system(.title, weight: .regular))
      .foregroundColor(.primary)
  }
}

struct MainScore_Previews: PreviewProvider {
  static var previews: some View {
    MainScore(teamName: "Team Name",
              matchOvers: 10,
              totalRuns: 125,
              totalWicketsDown: 1,
              oversDelivered: 5,
              ballsDelivered: 2)
  }
}


