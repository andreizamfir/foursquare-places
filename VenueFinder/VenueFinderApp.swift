//
//  VenueFinderApp.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import SwiftUI

@main
struct VenueFinderApp: App {
    @State private var venuesStore = VenuesStore(dataSource: .live())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(venuesStore)
        }
    }
}
