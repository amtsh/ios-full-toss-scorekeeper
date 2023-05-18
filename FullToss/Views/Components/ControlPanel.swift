//
//  ControlPanel.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct ControlPanel: View {

  var onRunsTap: (Int) -> Void
  var onWicketDownTap: () -> Void
  var onNoBallTap: () -> Void
  var onWideBallTap: () -> Void
  var onUndoTap: () -> Void
  var onRedoTap: () -> Void

  var body: some View {
    LazyHGrid(rows: [GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center)], spacing: 40) {

      Group {
        CircularButton(value: "4", onTap: {onRunsTap(4)})
        CircularButton(value: "2", onTap: {onRunsTap(2)})
        CircularButton(value: "0", onTap: {onRunsTap(0)})

        CircularButton(value: "arrow.uturn.left", type: .icon, onTap: onUndoTap)

        CircularButton(value: "6", onTap: {onRunsTap(6)})
        CircularButton(value: "3", onTap: {onRunsTap(3)})
        CircularButton(value: "1", onTap: {onRunsTap(1)})
        CircularButton(value: "arrow.uturn.right", type: .icon, onTap: onRedoTap)
      }
      Group {
        CircularButton(value: "W", textColor: Color.red, onTap: onWicketDownTap)
        CircularButton(value: "NB", opacity: 0.70, textColor: Color.black, onTap: onNoBallTap)
        CircularButton(value: "WB", opacity: 0.70, textColor: Color.black, onTap: onWideBallTap)
        CircularButton(value: "OK", textColor: .green)
      }
    }
    .padding()
  }

}
