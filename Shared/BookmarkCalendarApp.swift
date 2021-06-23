//
//  BookmarkCalendarApp.swift
//  Shared
//
//  Created by Jae Seung Lee on 6/23/21.
//

import SwiftUI

@main
struct BookmarkCalendarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
