//
//  NewMatchPreScreen.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct NewMatchPreScreen: View {
  @ObservedObject var matches: MatchesViewModel

  @State private var overs: Float = 10
  @State private var oversInput: String = "10"

  @State private var firstTeamName: String = "Team A"
  @State private var secondTeamName: String = "Team B"

  @State private var extrasEnabled: Bool = true

  @Environment(\.dismiss) var dismiss

  func onStartMatchTap() {
    let match = Match(
      firstTeam: ScoreBoardViewModel(firstTeamName, matchOvers: Int(overs)),
      secondTeam: ScoreBoardViewModel(
        secondTeamName,
        matchOvers: Int(overs)
      ),
      commonInfo: Match.CommonInfo()
    )

    matches.addMatch(match: match)
    dismiss()
  }

  var body: some View {
    NavigationView {

      Form {
        Section() {

          HStack {
            Text("Overs")
            Spacer()
            TextField("10", text: $oversInput)
              .onChange(of: oversInput) { newValue in
                overs = Float(newValue) ?? 0
              }
              .keyboardType(.numberPad)
              .multilineTextAlignment(.trailing)
          }

          Slider(value: $overs, in: 1...50, step: 1)
            .onChange(of: overs) { newValue in
              oversInput = String(format: "%.0f", overs)
            }
        }

        Section() {
          HStack {
            Text("First Team Name")
            Spacer()
            TextField("", text: $firstTeamName)
              .multilineTextAlignment(.trailing)
          }

          HStack {
            Text("Second Team Name")
            Spacer()
            TextField("", text: $secondTeamName)
              .multilineTextAlignment(.trailing)
          }
        }

        Section(footer: Text("1 run on wide or no ball delivery")) {
          Toggle("Extras", isOn: $extrasEnabled)
        }

        Button(
          action: {
            onStartMatchTap()
          },
          label: {
            ButtonFull(text: "Start Match", icon: "play.fill")
          }
        )
        .foregroundColor(.blue)


      }
      .padding(.horizontal, 0)
      .navigationBarTitle("New Match")

    }
    .padding(.top, 0)

  }
}

struct NewMatchPreScreen_Previews: PreviewProvider {
  static var previews: some View {
    NewMatchPreScreen(matches: MatchesViewModel())
  }
}
