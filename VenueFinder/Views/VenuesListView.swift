//
//  VenuesListView.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import SwiftUI

struct VenuesListView: View {
    @Environment(Services.self) var services
    
    var body: some View {
        let store = services.venuesStore
        
        return List {
            switch store.loadState {
            case .idle, .loading:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            case .failed(let message):
                ContentUnavailableView(
                    "Could not load venues",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
                .listRowSeparator(.hidden)
            case .loaded:
                ForEach(store.venues) { venue in
                    NavigationLink(screen: .venues(.detail(venue))) {
                        VenueRow(venue: venue)
                    }
                }
            }
        }
        .navigationTitle("Venues")
        .task { await store.load() }
        .refreshable { await store.load() }
    }
}

struct VenueRow: View {
    let venue: Venue

    var body: some View {
        Text(venue.name)
    }
}

#Preview {
    NavigationStack {
        VenuesListView()
    }
    .environment(Services.preview)
}
