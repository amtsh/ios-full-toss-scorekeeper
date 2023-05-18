//
//  ThisOver.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct ThisOver: View {

  @Binding var runsInCurrentOver: Int
  @Binding var ballsLeftInCurrentOver: Int
  @Binding var thisOver: [String]

  var body: some View {
    HStack {
      Text("This over")
        .font(.system(.caption, weight: .semibold))
        .foregroundColor(.secondary)
      Spacer()
      Text("\(runsInCurrentOver) runs (\(ballsLeftInCurrentOver) balls left)")
        .font(.system(.caption, weight: .medium))
        .foregroundColor(.secondary)
    }
    .padding(.top)
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .clipped()
    
    LazyHGrid(rows: [GridItem(.flexible(), spacing: 0, alignment: .center)], spacing: 30) {
      ForEach(thisOver.indices, id: \.self) { index in
        Text(thisOver[index])
          .font(.system(.largeTitle, weight: .semibold))
          .foregroundColor(.secondary)
      }
    }
  }
}
