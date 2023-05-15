//
//  TeamAUi.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

struct TeamAUi: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Group {
                    HStack {
                        Text("Team A")
                            .font(.headline)
                            .foregroundColor(.green)
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.horizontal)
                    Text("22 / 1")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .clipped()
                        .padding(.horizontal)
                        .font(.system(size: 70, weight: .black, design: .default))
                    Text("(3.2 / 10)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .clipped()
                        .padding(.horizontal)
                        .font(.system(.title, weight: .bold))
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack {
                        Text("Run rate")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                        Text("4.2")
                            .font(.system(.subheadline, weight: .medium))
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .clipped()
                    HStack {
                        Text("Projected Score")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                        Text("65")
                            .font(.system(.subheadline, weight: .medium))
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .clipped()
                    .padding(.bottom)
                    HStack {
                        Text("Extras")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.trailing)
                        Text("2 wides . 4 no balls")
                            .font(.system(.subheadline, weight: .medium))
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .clipped()
                }
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Divider()
                    HStack {
                        Text("Team B")
                            .font(.system(.headline, weight: .medium))
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
                        ForEach(0..<5) { _ in // Replace with your data model here
                            Text("1")
                                .font(.system(.title, weight: .black))
                                .foregroundColor(.secondary)
                        }
                    }
                    /* HStack {
                        Text("Undo")
                            .font(.system(.footnote, design: .rounded, weight: .semibold))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 7)
                            .background {
                                Rectangle()
                                    .fill(.clear)
                                    .background(Material.regular)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .clipped()
                        Text("Redo")
                            .font(.system(.footnote, design: .rounded, weight: .semibold))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 7)
                            .background {
                                Rectangle()
                                    .fill(.clear)
                                    .background(Material.regular)
                                    .mask {
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .clipped()
                    }
                }
                Group {
                    Circle()
                        .stroke(Color(.tertiaryLabel), lineWidth: 111)
                        .background(Circle().fill(Color(.quaternaryLabel)))
                        .scaleEffect(0.7, anchor: .center)
                        .overlay {
                            Image(systemName: "circle.inset.filled")
                                .imageScale(.large)
                                .symbolRenderingMode(.monochrome)
                                .font(.largeTitle)
                                .foregroundColor(.secondary)
                        } **/
                }
            }
        }
    }
}

struct TeamAUi_Previews: PreviewProvider {
    static var previews: some View {
        TeamAUi()
    }
}
