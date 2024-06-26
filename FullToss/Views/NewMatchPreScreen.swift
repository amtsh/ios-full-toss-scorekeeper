//
//  NewMatchPreScreen.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct NewMatchPreScreen: View {

  @State private var overs: Float = 10
  @State private var oversInput: String = "10"

  @State private var firstTeamName: String = "Team A"
  @State private var secondTeamName: String = "Team B"

  @State private var extrasEnabled: Bool = true

  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) var dismiss

  func onStartMatchTap() {
    let newMatch = Match(
      firstTeam: TeamScoreBoard(
        teamName: firstTeamName,
        matchOvers: Int(overs),
        extrasEnabled: extrasEnabled
      ),
      secondTeam: TeamScoreBoard(
        teamName: secondTeamName,
        matchOvers: Int(overs),
        extrasEnabled: extrasEnabled
      )
    )

    modelContext.insert(newMatch)
    dismiss()
  }

  var body: some View {
      NavigationStack {
        Group {
          Form {
            Section() {

              HStack {
                Text("Overs")
                Spacer()
                TextField("10", text: $oversInput)
                  .onChange(of: oversInput) { oldValue, newValue in
                    overs = Float(newValue) ?? 0
                  }
                  .keyboardType(.numberPad)
                  .multilineTextAlignment(.trailing)
              }

              Slider(value: $overs, in: 1...50, step: 1)
                .onChange(of: overs) { oldValue, newValue in
                  oversInput = String(format: "%.0f", overs)
                }
            }

            Section() {
              HStack {
                Text("First Team Name")
                Spacer()
                TextField("Team A", text: $firstTeamName)
                  .multilineTextAlignment(.trailing)
              }

              HStack {
                Text("Second Team Name")
                Spacer()
                TextField("Team B", text: $secondTeamName)
                  .multilineTextAlignment(.trailing)
              }
            }

            Section(
              footer: extrasEnabled
              ?
              Text("1 run on wide or no ball delivery")
              :
              Text("0 run on wide or no ball delivery")
            ) {
              Toggle("Extras", isOn: $extrasEnabled)
            }
          }
        }

        Group {
          FullButtonSecondary(
            text: "Start Match",
            icon: "play.fill",
            onTap: onStartMatchTap
          ).padding(.vertical, 0)
        }
        .navigationBarTitle("New Match")
      }
    .padding(.top, 0)

  }
}

struct NewMatchPreScreen_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      NewMatchPreScreen()
    }
  }
}
