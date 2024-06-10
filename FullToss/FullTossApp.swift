//
//  FullTossApp.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-15.
//

import SwiftUI
import SwiftData

@main
struct FullTossApp: App {
    var body: some Scene {
        WindowGroup {
            HomeUi()
        }
        .modelContainer(for: [Match.self, TeamScoreBoard.self])
    }
}
