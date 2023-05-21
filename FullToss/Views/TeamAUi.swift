//
//  TeamAUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

struct TeamAUi: View {
  @Binding var match: Match

  @State private var showMenu: Bool = false

  func addToRuns(runs: Int) {
    match.firstTeam.act(.ADDRUNS(runs))
  }
  func handleWicketDownTap() {
    match.firstTeam.act(.WICKETDOWN)
  }
  func handleWideBallTap() {
    match.firstTeam.act(.WIDEBALL)
  }
  func handleNoBallTap() {
    match.firstTeam.act(.NOBALL)
  }
  func handleEndFirstInningsTap() {
    match.firstTeam.act(.ENDINNINGS)
  }
  func handleUndoTap() {
    match.firstTeam.act(.UNDO)
  }
  func handleRedoTap() {
    match.firstTeam.act(.REDO)
  }

  var body: some View {
      VStack {
        VStack {
          ScrollView(showsIndicators: false) {
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
                projectedRuns: match.firstTeam.projectedRuns,
                wideBalls: match.firstTeam.extras.wideBalls,
                noBalls: match.firstTeam.extras.noBalls
              )
            }
          }
          Divider()
          YetToBat()
          Divider()

          ThisOver(
            runsInCurrentOver: match.firstTeam.overDetails.runsInCurrentOver,
            ballsLeftInCurrentOver: match.firstTeam.overDetails.ballsLeftInCurrentOver,
            thisOver: match.firstTeam.overDetails.thisOver
          )
        }

        if match.firstTeam.hasInningsEnded {
          NavigationLink(destination: TeamBUi(match: $match)) {
            ButtonFull(text: "Goto Second Innings", icon: "forward.fill")
          }
          .buttonStyle(.bordered)
          .padding(.horizontal)

        } else {
          ControlPanel(
            onRunsTap: addToRuns,
            onWicketDownTap: handleWicketDownTap,
            onNoBallTap: handleNoBallTap,
            onWideBallTap: handleWideBallTap,
            onUndoTap: handleUndoTap,
            onRedoTap: handleRedoTap
          )
        }


      }
      .padding(.top, 0)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Team A")
      .navigationBarItems(
        trailing: Button(action: {
          showMenu.toggle()
        }) {
          Image(systemName: "ellipsis")
        }
          .sheet(isPresented: $showMenu) {
            FirstInningsMenu()
              .presentationDetents([.fraction(0.3)])
              .presentationDragIndicator(.visible)
          }
      )
      .toolbar {
        ToolbarItem(placement: .principal) {
          LiveIndicator()
          .frame(maxWidth: .infinity, alignment: .top)
          .clipped()
        }
      }

  }
}

struct TeamAUi_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      TeamAUi(match: .constant(Match.sampleMatch))
    }
  }
}
