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

  func getDestination(match: Binding<Match>) -> AnyView {
    if !match.firstTeam.hasInningsEnded.wrappedValue {
      return AnyView(TeamAUi(match: match))
    }

    if !match.secondTeam.hasInningsEnded.wrappedValue {
      return AnyView(TeamBUi(match: match))
    }

    return AnyView(MatchSummaryUi(match: match))
  }

  var sortedMatches: Array<Binding<Match>> {
    $matches.matchesList.sorted(by: { $0.matchTimestamp.wrappedValue > $1.matchTimestamp.wrappedValue })
  }

  var body: some View {
    VStack {
      VStack {
        VStack {
          List(sortedMatches) { match in
            NavigationLink(destination: TeamAUi(match: match)) {
              MatchRow(
                title: "\(match.firstTeam.teamName.wrappedValue) vs \(match.secondTeam.teamName.wrappedValue)",
                matchTime: "\(getLocalTimeString( match.matchTimestamp.wrappedValue))",
                isMatchEnded: match.firstTeam.hasInningsEnded.wrappedValue && match.secondTeam.hasInningsEnded.wrappedValue
              )
            }
            .listRowBackground(Color.clear)
          }
          .listStyle(PlainListStyle())
          .scrollIndicators(.hidden)
        }
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

struct HomeUi_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      HomeUi()
    }

  }
}

struct MatchRow: View {
  var title: String = "Cricket Match #"
  var matchTime: String
  var isMatchEnded: Bool = false

  var body: some View {
    HStack() {
      Image(systemName: "circle.fill")
        .foregroundColor(isMatchEnded ? .gray : .green)
        .padding(.horizontal)
      VStack {
        Text(title)
          .font(.headline)
          .padding(.bottom, 2)
          .frame(maxWidth: .infinity, alignment: .leading)
          .clipped()
        Text(matchTime)
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
    FullButtonPrimary(
      text: "New Match",
      icon: "plus",
      onTap: {
        showNewMatchPreScreenSheet.toggle()
      }
    )
    .sheet(isPresented: $showNewMatchPreScreenSheet) {
      NewMatchPreScreen(matches: matches)
        .presentationDetents([.fraction(0.75), .large])
        .presentationDragIndicator(.visible)
    }
  }
}

