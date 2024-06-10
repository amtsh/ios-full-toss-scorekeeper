//
//  HomeUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-16.
//

import SwiftUI
import SwiftData

struct HomeUi: View {
  @Query(sort: \Match.matchTimestamp, order: .reverse)
  var matches: [Match]

  @Environment(\.modelContext) private var modelContext

  @Environment(\.scenePhase) private var scenePhase

  func handleDeleteMatch(at offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(matches[index])
      }
    }
  }

  var body: some View {
    NavigationStack {
      VStack {
        VStack {
          VStack {
            List {
              ForEach(matches) { match in
                NavigationLink(
                  destination: TeamAUi(match: match)
                ) {
                  MatchRow(
                    title: "\(match.firstTeam.teamName) vs \(match.secondTeam.teamName)",
                    matchTime: "\(getLocalTimeString( match.matchTimestamp))",
                    isMatchEnded: match.firstTeam.hasInningsEnded && match.secondTeam.hasInningsEnded
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
        NewMatchButtonSection()
          .padding(.vertical, 50)
          .padding(.horizontal)
      }
      .frame(maxWidth: .infinity)
      .padding(.top)
      .clipped()
      .navigationTitle("Matches")
      .toolbar {
        EditButton().disabled(matches.isEmpty)
      }
    }
  }
}

struct HomeUi_Previews: PreviewProvider {
  static var previews: some View {
      HomeUi()
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

  var body: some View {
    FullButtonPrimary(
      text: "New Match",
      icon: "plus",
      onTap: {
        showNewMatchPreScreenSheet.toggle()
      }
    )
    .sheet(isPresented: $showNewMatchPreScreenSheet) {
      NewMatchPreScreen()
        .presentationDetents([.fraction(0.75), .large])
        .presentationDragIndicator(.visible)
    }
  }
}

