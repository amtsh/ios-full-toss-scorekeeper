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
  static var fileName:String = "fulltoss.data"

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
    return try FileManager.default.url(for: .documentDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: false)
    .appendingPathComponent(Self.fileName)
  }

  private static func deleteFile() throws {
    var fileURL: URL

    do {
      fileURL = try Self.fileURL()
    } catch {
      return
    }

    let fileManager = FileManager.default

    // Check if the file exists at the specified URL
    if fileManager.fileExists(atPath: fileURL.path) {
      do {
        // Attempt to remove the file
        try fileManager.removeItem(at: fileURL)
        print("File deleted successfully.")
      } catch {
        // Handle any errors that occur during the deletion process
        print("Error deleting file: \(error.localizedDescription)")
        throw error
      }
    } else {
      // File doesn't exist at the specified URL
      print("File not found at path: \(fileURL.path)")
    }
  }

  func load() async throws {
//    try Self.deleteFile()

    let startTime = Date()

    print("Start: Loading from file")

    let task = Task<[Match], Error> {
      let fileURL = try Self.fileURL()
      let data = try Data(contentsOf: fileURL)

      let decoder = JSONDecoder()
      let matchesList = try decoder.decode([Match].self, from: data)
      return matchesList
    }

    let matchList = try await task.value
    self.matches = matchList

    print("End: Loaded from file")
    let endTime = Date()
    let executionTime = endTime.timeIntervalSince(startTime)
    print("LOADING execution time: \(executionTime) seconds")
  }


  func save(matches: [Match]) async throws {
    let startTime = Date()
    print("Start: Saving to file")

    let task = Task {
      let data = try JSONEncoder().encode(matches)
      let outfile = try Self.fileURL()
      try data.write(to: outfile)
      print("End: Saved to file")
      let endTime = Date()
      let executionTime = endTime.timeIntervalSince(startTime)
      print("SAVING execution time: \(executionTime) seconds")
    }
    _ = try await task.value
  }
}
