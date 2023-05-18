//
//  ThisOver.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct YetToBat: View {

  var body: some View {
    HStack {
      Text("TEAM B")
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
