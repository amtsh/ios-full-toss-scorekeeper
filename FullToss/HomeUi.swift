//
//  HomeUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-16.
//

import SwiftUI

struct HomeUi: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Full Toss")
                        .font(.system(.largeTitle, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipped()
                        
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
            Spacer()
            Text("Start New Match")
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
        .clipped()
        .padding(.top, 53)
        .padding(.bottom, 0)
        .padding(.horizontal, 29)
    }
}

struct HomeUi_Previews: PreviewProvider {
    static var previews: some View {
        HomeUi()
    }
}

