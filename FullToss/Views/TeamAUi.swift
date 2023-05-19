//
//  TeamAUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

struct TeamAUi: View {
  @ObservedObject var team: TeamScoreBoardViewModel

  @State private var showMenu: Bool = false

  func addToRuns(runs: Int) { team.reduce(action: TeamScoreBoardAction.ADDRUNS(runs: runs)) }
  func handleWicketDownTap() { team.reduce(action: TeamScoreBoardAction.WICKETDOWN) }
  func handleWideBallTap() { team.reduce(action: TeamScoreBoardAction.WIDEBALL) }
  func handleNoBallTap() { team.reduce(action: TeamScoreBoardAction.NOBALL) }
  func handleEndFirstInningsTap() { team.reduce(action: TeamScoreBoardAction.ENDINNINGS) }

  func handleUndoTap() { team.undo() }
  func handleRedoTap() { team.redo() }

  var body: some View {
      VStack {
        VStack {
          ScrollView(showsIndicators: false) {
            VStack {
              MainScore(
                teamName: $team.scoreBoard.teamName,
                matchOvers: $team.scoreBoard.matchOvers,
                totalRuns: $team.scoreBoard.runs,
                totalWicketsDown: $team.scoreBoard.wicketsDown,
                oversDelivered: $team.scoreBoard.oversDelivered,
                ballsDelivered: $team.scoreBoard.ballsDelivered
              )
              BattingExtraStats(
                currentRunRate: $team.scoreBoard.currentRunRate,
                projectedRuns: $team.scoreBoard.projectedRuns,
                wideBalls: $team.scoreBoard.extras.wideBalls,
                noBalls: $team.scoreBoard.extras.noBalls
              )
            }
          }
          Divider()
          YetToBat()
          Divider()

          ThisOver(
            runsInCurrentOver: $team.scoreBoard.overDetails.runsInCurrentOver,
            ballsLeftInCurrentOver: $team.scoreBoard.overDetails.ballsLeftInCurrentOver,
            thisOver: $team.scoreBoard.overDetails.thisOver
          )
        }

        if $team.scoreBoard.hasInningsEnded.wrappedValue {
          AfterInningsEndButton(text: "Start Second Innings", onTap: {})
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
      .navigationTitle("Hello")
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
    let previewTeam = TeamScoreBoardViewModel("TEAM A", matchOvers: 10);

    TeamAUi(team: previewTeam)
  }
}

