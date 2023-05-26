//
//  MatchesViewModel.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-19.
//

import SwiftUI

@MainActor
class MatchesManager: ObservableObject {
  @Published var matches: [Match]

  init() {
    self.matches = []
  }

  func createMatch(match: Match) {
    self.matches.append(match)
  }

  func deleteMatch(_ match: Match) {
    if let index = matches.firstIndex(where: { $0.id == match.id }) {
      matches.remove(at: index)
    }
  }

  private static func fileURL() throws -> URL {
    try FileManager.default.url(for: .documentDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
    .appendingPathComponent("fulltoss.data")
  }

  func load() async throws {
    print("Loading from files")

    let task = Task<[Match], Error> {
      let fileURL = try Self.fileURL()
      guard let data = try? Data(contentsOf: fileURL) else {
        return []
      }

      let matchesList = try JSONDecoder().decode([Match].self, from: data)
      return matchesList
    }
    let matchList = try await task.value
    self.matches = matchList
  }

  func save(matches: [Match]) async throws {
    print("Saving to files")

    let task = Task {
      let data = try JSONEncoder().encode(matches)
      let outfile = try Self.fileURL()
      try data.write(to: outfile)
    }
    _ = try await task.value
  }
}
