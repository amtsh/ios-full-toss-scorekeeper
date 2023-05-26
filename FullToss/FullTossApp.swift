//
//  FullTossApp.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI

@main
struct FullTossApp: App {
  @StateObject private var matchesManager = MatchesManager()
  @State private var isAppLoaded = false

  func loadMatchesfromDisk() {
    Task {
      do {
        try await matchesManager.load()
        isAppLoaded = true
      } catch {
        // Handle load error
      }
    }
  }

  func saveMatchesToDisk() -> Void {
    Task {
      do {
        try await matchesManager.save(matches: matchesManager.matches)
      } catch {
        // encountered an error writing to the file system
      }
    }
  }

    var body: some Scene {
        WindowGroup {
          NavigationStack {
            HomeUi(matchesManager: matchesManager, saveAction: saveMatchesToDisk)
              .onAppear {
                if !isAppLoaded {
                  loadMatchesfromDisk()
                }
              }
          }
        }
    }
}
