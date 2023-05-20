//
//  HomeUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-16.
//

import SwiftUI
import Foundation

struct HomeUi: View {
  @StateObject var matches = MatchesManager()

  func getDestination(match: Match) -> AnyView {
    if !match.firstTeam.scoreBoard.hasInningsEnded {
      return AnyView(TeamAUi(team: match.firstTeam))
    }

    if !match.secondTeam.scoreBoard.hasInningsEnded {
      return AnyView(TeamBUi(team: match.secondTeam))
    }

    return AnyView(MatchSummaryUi(match: match))
  }

  var body: some View {
    NavigationView {
      VStack {
        VStack {
          List(matches.matchesList) { match in // Replace with your data model here

            NavigationLink(destination: getDestination(match: match)) {

              MatchRow(
                title: "\(match.firstTeam.scoreBoard.teamName) vs \(match.secondTeam.scoreBoard.teamName)",
                matchDate: "\(match.matchDate)"
              )
            }
            .listRowBackground(Color.clear)
          }
          .listStyle(PlainListStyle())
          .scrollIndicators(.hidden)
        }

        Spacer()
        NewMatchButtonSection(matches: matches)
          .padding(.vertical, 50)
          .padding(.horizontal)

      }
      .frame(maxWidth: .infinity)
      .padding(.top)
      .clipped()
      .navigationTitle("Matches")
    }
  }

}

struct HomeUi_Previews: PreviewProvider {
  static var previews: some View {
    HomeUi()
  }
}

struct ButtonFull: View {
  var text: String = "Button"
  var icon = ""

  var body: some View {
    Label(text, systemImage: icon)
      .font(.system(.callout, weight: .semibold))
      .padding(.vertical, 10)
      .frame(maxWidth: .infinity)
      .clipped()
  }
}

struct MatchRow: View {
  var title: String = "Cricket Match #"
  var matchDate = getCurrentDate()

  var body: some View {
    HStack(spacing: 0) {
      VStack {
        Text(title)
          .font(.headline)
          .padding(.bottom, 2)
          .frame(maxWidth: .infinity, alignment: .leading)
          .clipped()
        Text(matchDate)
          .frame(maxWidth: .infinity, alignment: .leading)
          .clipped()
          .foregroundColor(.secondary)
      }
    }
    .font(.subheadline)
  }
}

struct NewMatchButtonSection: View {
  @State private var showNewMatchPreScreenSheet: Bool = false
  @ObservedObject var matches: MatchesManager

  var body: some View {
    Button(
      action: {
        showNewMatchPreScreenSheet.toggle()
      },
      label: {
        ButtonFull(text: "New Match")
      }
    )
    .buttonStyle(.borderedProminent)
    .sheet(isPresented: $showNewMatchPreScreenSheet) {
      NewMatchPreScreen(matches: matches)
        .presentationDetents([.fraction(0.75), .large])
        .presentationDragIndicator(.visible)
    }
  }
}

