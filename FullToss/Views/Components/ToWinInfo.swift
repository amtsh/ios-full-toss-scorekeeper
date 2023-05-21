//
//  ToWinInfo.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct ToWinInfo: View {

  var match: Match

  var body: some View {

    if(!match.firstTeam.hasInningsEnded) {
      return AnyView(Text("Innings not started"))
    }

    if(match.secondTeam.hasInningsEnded) {
      return AnyView(
        Text("\(match.winner) WON")
        .font(.system(.headline, weight: .heavy))
        .foregroundColor(.pink)
      )
    }

    return AnyView(HStack {
      Text("To win:")
      Text("\(match.runsToWin) runs in \(match.secondTeam.ballsRemainingInMatch) balls")
        .font(.system(.headline, weight: .heavy))
        .foregroundColor(.pink)
    })
  }
}

struct ToWinInfo_Previews: PreviewProvider {
  static var previews: some View {
    ToWinInfo(match: Match.sampleMatch)
  }
}

