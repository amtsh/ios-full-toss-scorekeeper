//
//  HomeUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-16.
//

import SwiftUI

struct HomeUi: View {

  var body: some View {
    NavigationView {
      VStack {
        ScrollView(showsIndicators: false) {
          VStack {
            ForEach(0..<5) { i in // Replace with your data model here
              Divider()
                .opacity(0.5)
              HStack(spacing: 0) {
                VStack {
                  Text("Cricket Match \(i+1)")
                    .font(.headline)
                    .padding(.bottom, 2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipped()
                  Text("30 May 2023")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipped()
                    .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "ellipsis")
              }
              .padding(.vertical)
              .font(.subheadline)
            }
          }
        }
        .padding(.top, 1)
        Spacer()
        NavigationLink(destination: TeamAUi()) {
          Text("New Match")
            .font(.headline)
        }

        Text("New Match")
          .font(.system(.callout, weight: .semibold))
          .padding()
          .frame(maxWidth: .infinity)
          .clipped()
          .foregroundColor(.white)
          .background(.blue)
          .mask { RoundedRectangle(cornerRadius: 16, style: .continuous) }
          .padding(.bottom, 60)
      }
      .frame(maxWidth: .infinity)
      .padding(.top)
      .padding(.bottom, 0)
      .padding(.horizontal, 29)
      .navigationTitle("Matches")
      .clipped()
    }
  }

}

struct HomeUi_Previews: PreviewProvider {
  static var previews: some View {
    HomeUi()
  }
}
