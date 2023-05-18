//
//   BattingExtraStats.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct BattingExtraStats: View {

  @Binding var currentRunRate: Float
  @Binding var projectedRuns: Int
  @Binding var wideBalls: Int
  @Binding var noBalls: Int

  var body: some View {
    VStack {
      HStack {
        Text("Run rate")
        Text("\(formatFloatValue(currentRunRate) ?? "")")
      }
      .padding(.horizontal)
      .padding(.bottom, 5)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .foregroundColor(.secondary)
      .font(.system(.subheadline, weight: .regular))
      .clipped()
      HStack {
        Text("Projected Score")
        Text("\(projectedRuns)")
      }
      .padding(.horizontal)
      .padding(.bottom, 5)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .foregroundColor(.secondary)
      .font(.system(.subheadline, weight: .regular))
      .clipped()
      HStack {
        Text("Extras")
        Text("\(wideBalls) Wides · \(noBalls) No balls")
      }
      .padding(.horizontal)
      .padding(.bottom, 5)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .foregroundColor(.secondary)
      .font(.system(.subheadline, weight: .regular))
      .clipped()
    }
    .padding(.top, 1)
  }
}
