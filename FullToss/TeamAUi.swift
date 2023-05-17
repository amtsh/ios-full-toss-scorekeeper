//
//  TeamAUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

struct TeamAUi: View {
  var body: some View {
    VStack {
      VStack {
        VStack {
          ScrollView(showsIndicators: false) {
            VStack {
              HStack() {
                Text("TEAM A")
                  .font(.system(.headline, weight: .bold))
                  .foregroundColor(.green)
                Spacer()
                Text("22 - 1")
                  .frame(maxWidth: .infinity, alignment: .trailing)
                  .clipped()
                  .font(.system(size: 60, weight: .regular, design: .default))
              }
              .padding(.top, 16)
              .padding(.horizontal)
              Text("(3.2 / 10)")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .clipped()
                .padding(.horizontal)
                .font(.system(.title, weight: .regular))
                .foregroundColor(.primary)
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
                  Text("2 wides . 4 no balls")
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
          Divider()
          HStack {
            Text("TEAM B")
              .font(.system(.subheadline, weight: .medium))
              .foregroundColor(Color(.tertiaryLabel))
            Spacer()
            Text("Yet to bat")
              .font(.system(.subheadline, weight: .medium))
              .foregroundColor(Color(.tertiaryLabel))
          }
          .padding(.horizontal)
          .frame(maxWidth: .infinity, alignment: .leading)
          .clipped()
          Divider()
          HStack {
            Text("This over")
              .font(.system(.caption, weight: .semibold))
              .foregroundColor(.secondary)
            Spacer()
            Text("13 runs (1 ball left)")
              .font(.system(.caption, weight: .medium))
              .foregroundColor(.secondary)
          }
          .padding(.top)
          .padding(.horizontal)
          .frame(maxWidth: .infinity, alignment: .leading)
          .clipped()
          LazyHGrid(rows: [GridItem(.flexible(), spacing: 0, alignment: .center)], spacing: 50) {
            Text("4")
              .font(.system(.largeTitle, weight: .semibold))
              .foregroundColor(.secondary)
            Text("2")
              .font(.system(.largeTitle, weight: .semibold))
              .foregroundColor(.secondary)
            Text("6")
              .font(.system(.largeTitle, weight: .semibold))
              .foregroundColor(.secondary)
            Text("W")
              .font(.system(.largeTitle, weight: .semibold))
              .foregroundColor(.secondary)
            Text("1")
              .font(.system(.largeTitle, weight: .semibold))
              .foregroundColor(.secondary)
          }
        }
        LazyHGrid(rows: [GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center), GridItem(.flexible(), alignment: .center)], spacing: 40) {
          
          Group {
            ScoreInputText(value: "4")
            ScoreInputText(value: "2")
            ScoreInputText(value: "0")
            
            ScoreInputIcon(value: "arrow.uturn.left")
              .imageScale(.large)
            
            ScoreInputText(value: "6")
            ScoreInputText(value: "3")
            ScoreInputText(value: "1")
            
            
            ScoreInputIcon(value: "arrow.uturn.right")
              .imageScale(.large)
            
            ScoreInputText(value: "W", opacity: 0.15, textColor: Color.red)
            ScoreInputText(value: "NB", opacity: 0.60, textColor: Color.black)
          }
          Group {
            ScoreInputText(value: "WB", opacity: 0.60, textColor: Color.black)
            ScoreInputText(value: "OK", textColor: .green)
          }
          
        }
        .padding()
      }
    }
  }
}

struct TeamAUi_Previews: PreviewProvider {
  static var previews: some View {
    TeamAUi()
  }
}

