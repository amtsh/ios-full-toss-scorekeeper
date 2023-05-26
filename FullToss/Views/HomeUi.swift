//
//  HomeUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-16.
//

import SwiftUI
import Foundation

struct HomeUi: View {
  @ObservedObject var matchesManager: MatchesManager

  @Environment(\.scenePhase) private var scenePhase

  let saveAction: ()->Void

  func getDestination(match: Binding<Match>) -> AnyView {
    if !match.firstTeam.hasInningsEnded.wrappedValue {
      return AnyView(TeamAUi(match: match))
    }

    if !match.secondTeam.hasInningsEnded.wrappedValue {
      return AnyView(TeamBUi(match: match))
    }

    return AnyView(MatchSummaryUi(match: match))
  }

  func handleDeleteMatch(at offsets: IndexSet) {
    guard let index = offsets.first,
          index < sortedMatches.count else {
      return
    }

    let match = sortedMatches[index].wrappedValue
    matchesManager.deleteMatch(match)
  }

  var sortedMatches: Array<Binding<Match>> {
    $matchesManager.matches.sorted(by: { $0.matchTimestamp.wrappedValue > $1.matchTimestamp.wrappedValue })
  }

  var body: some View {
    VStack {
      VStack {
        VStack {
          List {
            ForEach(sortedMatches) { match in
              NavigationLink(
                destination: TeamAUi(match: match)
              ) {
                MatchRow(
                  title: "\(match.firstTeam.teamName.wrappedValue) vs \(match.secondTeam.teamName.wrappedValue)",
                  matchTime: "\(getLocalTimeString( match.matchTimestamp.wrappedValue))",
                  isMatchEnded: match.firstTeam.hasInningsEnded.wrappedValue && match.secondTeam.hasInningsEnded.wrappedValue
                )
              }
            }
            .onDelete(perform: handleDeleteMatch)
            .listRowBackground(Color.clear)

          }
          .listStyle(PlainListStyle())
          .scrollIndicators(.hidden)
        }
      }

      Spacer()
      NewMatchButtonSection(matchesManager: matchesManager)
        .padding(.vertical, 50)
        .padding(.horizontal)
    }
    .onChange(of: scenePhase) { phase in
      if phase == .inactive { saveAction() }
    }
    .frame(maxWidth: .infinity)
    .padding(.top)
    .clipped()
    .navigationTitle("Matches")
    .toolbar {
      EditButton().disabled(sortedMatches.isEmpty)
    }
  }
}

struct HomeUi_Previews: PreviewProvider {
  static var previews: some View {
    let matchesManager = MatchesManager()

    NavigationStack {
      HomeUi(matchesManager: matchesManager) {}
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
  @ObservedObject var matchesManager: MatchesManager

  var body: some View {
    FullButtonPrimary(
      text: "New Match",
      icon: "plus",
      onTap: {
        showNewMatchPreScreenSheet.toggle()
      }
    )
    .sheet(isPresented: $showNewMatchPreScreenSheet) {
      NewMatchPreScreen(matchesManager: matchesManager)
        .presentationDetents([.fraction(0.75), .large])
        .presentationDragIndicator(.visible)
    }
  }
}

