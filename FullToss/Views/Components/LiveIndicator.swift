//
//  CircularButton.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI

struct LiveIndicator: View {

  var body: some View {
    HStack {
      Circle()
        .fill(.green)
        .frame(width: 5, height: 5)
        .clipped()
      Text("Live")
        .font(.system(.caption))
    }
  }
}

struct LiveIndicator_Previews: PreviewProvider {
  static var previews: some View {
    LiveIndicator()
  }
}

