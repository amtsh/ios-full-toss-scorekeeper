//
//  CircularButton.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

enum CircularButtonType {
  case text
  case icon
}

struct CircularButton: View {
  var value = "#"
  var type: CircularButtonType = .text
  var opacity = 0.25
  var textColor = Color.primary
  var bgColor = Color.secondary
  var onTap: () -> Void = {}
  var isButtonDisabled: Bool = false
  

  var body: some View {
    Button(action: {
      // Action to perform when the button is tapped
      self.onTap()
    }) {
      ZStack {
        Circle()
          .fill(bgColor.opacity(opacity))
          .clipped()

        if type == .text {
          Text(value)
            .font(.system(.largeTitle, weight: .medium))
            .foregroundColor(textColor)
        }
        else {
          Image(systemName: value)
            .foregroundColor(.primary)
            .imageScale(.large)
            .font(.system(.title3, weight: .medium))
        }
      }
    }
    .buttonStyle(.plain)
    .disabled(isButtonDisabled)
  }
}

struct CircularButton_Previews: PreviewProvider {
  static var previews: some View {
    CircularButton()
  }
}

