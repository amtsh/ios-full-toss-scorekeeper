//
//   BattingExtraStats.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct MainScore: View {

  @Binding var teamName: String
  @Binding var matchOvers: Int
  @Binding var totalRuns: Int
  @Binding var totalWicketsDown: Int
  @Binding var oversDelivered: Int
  @Binding var ballsDelivered: Int

  var body: some View {
    HStack() {
      Text("\(teamName)")
        .font(.system(.headline, weight: .bold))
        .foregroundColor(.green)
      Spacer()
      Text("\(totalRuns) - \(totalWicketsDown)")
        .frame(maxWidth: .infinity, alignment: .trailing)
        .clipped()
        .font(.system(size: 60, weight: .regular, design: .default))
    }
    .padding(.top, 16)
    .padding(.horizontal)
    Text("(\(oversDelivered).\(ballsDelivered) / \(matchOvers))")
      .frame(maxWidth: .infinity, alignment: .trailing)
      .clipped()
      .padding(.horizontal)
      .font(.system(.title, weight: .regular))
      .foregroundColor(.primary)
  }
}
