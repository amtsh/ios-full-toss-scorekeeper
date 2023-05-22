//
//  EndFirstInningsButton.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct AfterInningsEndButton: View {

  var text: String
//  var onTap: () -> Void

  var body: some View {
    Section {
      FullButtonSecondary(text: text, icon: "forward.fill")
    }
  }
}

struct EndFirstInningsButton_Previews: PreviewProvider {
  static var previews: some View {
    AfterInningsEndButton(text: "Start Second Innings")
  }
}

