//
//  TeamAUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

struct TeamAUi: View {
  @Bindable var match: Match

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
  func handleByeTap() {
    match.firstTeam.act(.BYE)
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
          YetToBat(teamName: match.secondTeam.teamName)
          Divider()

          ThisOver(
            runsInCurrentOver: match.firstTeam.overDetails.runsInCurrentOver,
            ballsLeftInCurrentOver: match.firstTeam.ballsLeftInCurrentOver,
            thisOver: match.firstTeam.overDetails.thisOver
          )
        }

        if match.firstTeam.hasInningsEnded {
          NavigationLink(destination: TeamBUi(match: match)) {

            FullButtonNav(
            text: "Goto Second Innings", icon: "forward.fill"
            )
          }
          .buttonStyle(.bordered)
          .tint(.pink)
          .foregroundColor(.pink)
          .padding(.horizontal)

        } else {
          ControlPanel(
            onRunsTap: addToRuns,
            onWicketDownTap: handleWicketDownTap,
            onNoBallTap: handleNoBallTap,
            onWideBallTap: handleWideBallTap,
            onByeTap: handleByeTap,
            onUndoTap: handleUndoTap,
            onRedoTap: handleRedoTap,
            canUndo: match.firstTeam.canUndo,
            canRedo: match.firstTeam.canRedo
          )
        }


      }
      .padding(.top, 0)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("First Innings")
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
          if !match.isMatchEnded {
            LiveIndicator()
              .frame(maxWidth: .infinity, alignment: .top)
              .clipped()
          }
        }
      }

  }
}

struct TeamAUi_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      TeamAUi(match: Match.sampleMatch)
    }
  }
}
