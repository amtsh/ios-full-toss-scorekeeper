//
//  FirstInningsMenu.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct SecondInningsMenu: View {

  var body: some View {
    VStack(spacing: 0) {
      List() {

        HStack(alignment: .firstTextBaseline) {
          Image(systemName: "square.and.arrow.up")
            .frame(width: 20)
            .clipped()
          Text("Share")
            .foregroundColor(.primary)
          Spacer()
        }
        .padding(.leading)
        .font(.subheadline)
        .foregroundColor(.blue)

        Section {
          Button(
            action: {
            },
            label: {
              ButtonFull(text: "End Match", icon: "stop.fill")
            }
          )
          .foregroundColor(.red)
        }
      }


    }
  }
}

struct SecondInningsMenu_Previews: PreviewProvider {
  static var previews: some View {
    SecondInningsMenu()
  }
}


