//
//  FirstInningsMenu.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

struct FirstInningsMenu: View {

  var body: some View {
    VStack(spacing: 0) {
      List() {
        HStack(alignment: .firstTextBaseline) {
          Image(systemName: "square.and.arrow.up")
            .frame(width: 20)
            .clipped()
          Text("Extend overs")
            .foregroundColor(.primary)
          Spacer()
        }
        .padding(.leading)
        .font(.subheadline)
        .foregroundColor(.blue)

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
              ButtonFull(text: "Start Second Innings", icon: "forward.fill")
            }
          )
          .foregroundColor(.red)
        }
      }


    }
  }
}

struct FirstInningsMenu_Previews: PreviewProvider {
  static var previews: some View {
    FirstInningsMenu()
  }
}


