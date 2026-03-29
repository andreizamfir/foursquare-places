//
//  VenueFinderApp.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import SwiftUI

@main
struct VenueFinderApp: App {
    @State private var services = Services.live
    @State private var navigator = Navigator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(services)
                .environment(navigator)
        }
    }
}
