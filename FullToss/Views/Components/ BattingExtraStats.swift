//
//   BattingExtraStats.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct BattingExtraStats: View {

  @Binding var wideBalls: Int
  @Binding var noBalls: Int

  var body: some View {
    VStack {
      HStack {
        Text("Run rate")
        Text("4.2")
      }
      .padding(.horizontal)
      .padding(.bottom)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .clipped()
      .foregroundColor(.secondary)
      .font(.system(.caption, weight: .semibold))
      HStack {
        Text("Projected Score")
        Text("65")
      }
      .padding(.horizontal)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .clipped()
      .padding(.bottom)
      .foregroundColor(.secondary)
      .font(.system(.caption, weight: .semibold))
      HStack {
        Text("Extras")
        Text("\(wideBalls) wides · \(noBalls) no balls")
      }
      .padding(.horizontal)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .clipped()
      .foregroundColor(.secondary)
      .font(.system(.caption, weight: .semibold))
    }
    .padding(.top, 1)
  }
}
