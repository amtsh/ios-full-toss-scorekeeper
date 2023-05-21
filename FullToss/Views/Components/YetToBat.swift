//
//  ThisOver.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct YetToBat: View {

  var teamName: String = "TEAM B"

  var body: some View {
    HStack {
      Text("\(teamName)")
        .font(.system(.subheadline, weight: .medium))
        .foregroundColor(Color(.tertiaryLabel))
      Spacer()
      Text("Yet to bat")
        .font(.system(.subheadline, weight: .medium))
        .foregroundColor(Color(.tertiaryLabel))
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .clipped()
  }
}
