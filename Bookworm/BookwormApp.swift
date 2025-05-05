//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Vitaliy Novichenko on 05.05.2025.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
