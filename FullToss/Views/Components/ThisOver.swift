//
//  ThisOver.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct ThisOver: View {

  var runsInCurrentOver: Int
  var ballsLeftInCurrentOver: Int
  var thisOver: [String]

  var body: some View {
    HStack {
      Text("This over")
      Spacer()
      Text("\(runsInCurrentOver) runs (\(ballsLeftInCurrentOver) balls left)")
    }
    .padding(.top)
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .font(.system(.subheadline, weight: .regular))
    .foregroundColor(.secondary)
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
