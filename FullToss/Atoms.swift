//
//  Atoms.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-17.
//

import SwiftUI


struct ScoreInputText: View {
  var value = "#"
  var opacity = 0.25
  var textColor = Color.primary
  var bgColor = Color.secondary
  
  var body: some View {
    ZStack {
      Circle()
        .fill(bgColor.opacity(opacity))
        .clipped()
      Text(value)
        .font(.system(.largeTitle, weight: .medium))
        .foregroundColor(textColor)
    }
  }
}

struct ScoreInputIcon: View {
  var value = "paperplane"
  
  var body: some View {
    ZStack {
      Circle()
        .fill(.secondary.opacity(0.25))
        .clipped()
      Image(systemName: value)
        .foregroundColor(.primary)
    }
  }
}
