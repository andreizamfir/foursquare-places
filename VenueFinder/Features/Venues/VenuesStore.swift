//
//  VenuesStore.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import Observation

@MainActor
@Observable final class VenuesStore {
    enum LoadState {
        case idle
        case loading
        case loaded
        case failed(String)
    }

    // Only the store can modify those values, other classes can only read them
    private(set) var venues: [Venue] = []
    private(set) var loadState: LoadState = .idle

    private let service: VenueService

    nonisolated init(service: VenueService) {
        self.service = service
    }

    func load(policy: CachePolicy = .cacheThenFetch) async {
        loadState = .loading
        do {
            venues = try await service.fetchVenues(policy)
            loadState = .loaded
        } catch {
            loadState = .failed(error.localizedDescription)
        }
    }
}
