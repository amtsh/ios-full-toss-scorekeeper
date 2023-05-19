//
//  EndFirstInningsButton.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct AfterInningsEndButton: View {

  var text: String
  var onTap: () -> Void

  var body: some View {
    Section {
      Button(
        action: onTap,
        label: {
          ButtonFull(text: text, icon: "forward.fill")
        }
      )
      .foregroundColor(.red)
    }
  }
}

struct EndFirstInningsButton_Previews: PreviewProvider {
  static var previews: some View {
    AfterInningsEndButton(text: "Start Second Innings", onTap: {})
  }
}

