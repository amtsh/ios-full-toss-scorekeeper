//
//  CircularButton.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct FullButtonPrimary: View {
  var text: String = "Primary Button"
  var icon = "swift"
  var onTap: () -> Void = {}

  var body: some View {

    Button(
      action: onTap,
      label: {
        Label(text, systemImage: icon)
          .font(.system(.callout, weight: .semibold))
          .padding(.vertical, 10)
          .frame(maxWidth: .infinity)
          .clipped()
      }
    )
    .buttonStyle(.borderedProminent)
    .tint(.pink)
  }
}

struct FullButtonSecondary: View {
  var text: String = "Secondary Button"
  var icon = "swift"
  var onTap: () -> Void = {}

  var body: some View {

    Button(
      action: onTap,
      label: {
        Label(text, systemImage: icon)
          .font(.system(.callout, weight: .semibold))
          .padding(.vertical, 10)
          .frame(maxWidth: .infinity)
          .clipped()
      }
    )
    .buttonStyle(.bordered)
    .tint(.pink)
  }
}

struct FullButtonNav: View {
  var text: String = "Nav Button"
  var icon = ""


  var body: some View {
      Label(text, systemImage: icon)
        .font(.system(.callout, weight: .semibold))
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .clipped()
  }
}

struct FullButtonPrimary_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      FullButtonPrimary()
      FullButtonSecondary(icon: "play.fill")
      FullButtonNav()
    }
  }
}

