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
    VStack {
      HStack {
        Text("This over")
        Spacer()
        Text("\(runsInCurrentOver) runs (\(ballsLeftInCurrentOver) balls left)")
      }
      .padding(.vertical, 5)
      .padding(.horizontal)
      .frame(maxWidth: .infinity, alignment: .leading)
      .font(.system(.subheadline, weight: .regular))
      .foregroundColor(.secondary)
      .clipped()

      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: [GridItem(.flexible(), alignment: .center)], spacing: 40) {
          ForEach(thisOver.indices, id: \.self) { index in
            Text(thisOver[index])
              .font(.system(.largeTitle, weight: .semibold))
              .foregroundColor(.secondary)
              .id(index)
          }
        }.padding(.horizontal)
      }
      .padding(.horizontal)
    }
  }
}

struct ThisOver_Previews: PreviewProvider {
  static var previews: some View {
    ThisOver(runsInCurrentOver: 20, ballsLeftInCurrentOver: 1, thisOver: ["6","4","3","2","1", "11"]
    )
  }
}
