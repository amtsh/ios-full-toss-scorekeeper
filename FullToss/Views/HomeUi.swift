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

  var body: some View {
    NavigationStack {
      VStack {
        VStack {
          List($matches.matchesList) { match in
            NavigationLink(destination: TeamAUi(match: match)) {
              MatchRow(
                title: "\(match.firstTeam.teamName.wrappedValue) vs \(match.secondTeam.teamName.wrappedValue)",
                matchDate: "\(match.matchDate.wrappedValue)",
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

