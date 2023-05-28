//
//  TeamAUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

struct TeamBUi: View {
  @Binding var match: Match
  @State private var showMenu: Bool = false

  func watchWinningScore() {
    if match.hasSecondTeamWon {
      match.secondTeam.act(.ENDINNINGS)
    }
  }

  func addToRuns(runs: Int) {
    match.secondTeam.act(.ADDRUNS(runs))
    watchWinningScore()
  }
  func handleWicketDownTap() {
    match.secondTeam.act(.WICKETDOWN)
  }
  func handleWideBallTap() {
    match.secondTeam.act(.WIDEBALL)
    watchWinningScore()
  }
  func handleNoBallTap() {
    match.secondTeam.act(.NOBALL)
    watchWinningScore()
  }
  func handleEndFirstInningsTap() {
    match.secondTeam.act(.ENDINNINGS)
  }

  func handleUndoTap() {
    match.secondTeam.act(.UNDO)
  }
  func handleRedoTap() {
    match.secondTeam.act(.REDO)
  }

  var body: some View {
      VStack {
        VStack {
          ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
              HStack {
                Text("\(match.firstTeam.teamName)")
                  .font(.headline)
                  .foregroundColor(.secondary)
                Spacer()
                Text("\(match.firstTeam.runs)-\(match.firstTeam.wicketsDown) (\(match.firstTeam.oversDelivered).\(match.firstTeam.ballsDelivered))")
                  .font(.system(.headline, weight: .black))
                  .foregroundColor(.secondary)
              }
              .padding(.vertical)
              .padding(.horizontal)

              Divider()

              VStack{
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
                  projectedRuns: match.secondTeam.projectedRuns,
                  wideBalls: match.secondTeam.extras.wideBalls,
                  noBalls: match.secondTeam.extras.noBalls
                )
              }
            }
          }
          Divider()
          ToWinInfo(match: match)
          Divider()

          ThisOver(
            runsInCurrentOver: match.secondTeam.overDetails.runsInCurrentOver,
            ballsLeftInCurrentOver: match.secondTeam.ballsLeftInCurrentOver,
            thisOver: match.secondTeam.overDetails.thisOver
          )
        }

        if match.secondTeam.hasInningsEnded {
          NavigationLink(destination: MatchSummaryUi(match: $match)) {
            FullButtonNav(text: "See Match Summary", icon: "medal")
          }
          .buttonStyle(.bordered)
          .tint(.pink)
          .padding(.horizontal)
        } else {
          ControlPanel(
            onRunsTap: addToRuns,
            onWicketDownTap: handleWicketDownTap,
            onNoBallTap: handleNoBallTap,
            onWideBallTap: handleWideBallTap,
            onUndoTap: handleUndoTap,
            onRedoTap: handleRedoTap,
            canUndo: match.secondTeam.canUndo,
            canRedo: match.secondTeam.canRedo
          )
        }

      }
      .padding(.top, 0)
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Second Innings")
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

struct TeamBUi_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      TeamBUi(match: .constant(Match.sampleMatch))
    }
  }
}

