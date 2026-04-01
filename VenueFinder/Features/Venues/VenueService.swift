//
//  VenueDataSource.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

struct VenueService {
    var fetchVenues: (CachePolicy) async throws -> [Venue]
}

extension VenueService {
    
    static func live(apiKey: String = "RSGW01XR1Y1CAYG04EM3BP1EM0TXGDGSMCF11AKMKYZSDPOR") -> VenueService {
        let cache = TieredCache.default
        let client = HTTPClient.live(apiKey: apiKey)
        
        return VenueService { policy in
            try await apply(policy: policy, cache: cache) {
                let response = try await client.decode(
                    VenuesApiResponse.self,
                    from: FoursquareEndpoints.searchPlaces(latitude: 40.7, longitude: -74.0)
                )
                return response.venues.compactMap { $0.domainModel }
            }
        }
    }
    
    static func json() -> VenueService {
        let cache = TieredCache.default
        
        return VenueService { policy in
            try await apply(policy: policy, cache: cache) {
                guard let url = Bundle.main.url(forResource: "venues", withExtension: "json"),
                      let data = try? Data(contentsOf: url)
                else { throw VenueDataSourceError.bundleResourceNotFound("venues.json") }
                
                let response = try JSONDecoder().decode(VenuesApiResponse.self, from: data)
                return response.venues.compactMap { $0.domainModel }
            }
        }
    }
    
    static func mock(_ venues: [Venue] = .previews) -> VenueService {
        let cache = TieredCache.default
        
        return VenueService { policy in
            try await apply(policy: policy, cache: cache) {
                try await Task.sleep(for: .milliseconds(500))
                return venues
            }
        }
    }
    
    static func preview(_ venues: [Venue] = .previews) -> VenueService {
        let cache = TieredCache.default
        
        return VenueService { policy in
            try await apply(policy: policy, cache: cache) { venues }
        }
    }
    
    static func unimplemented() -> VenueService {
        VenueService { _ in fatalError("Data source not implemented") }
    }
}

// MARK: - Cache Policy Application

private func apply(
    policy: CachePolicy,
    cache: TieredCache,
    fetch: @escaping () async throws -> [Venue]
) async throws -> [Venue] {
    switch policy {
    case .cacheThenFetch:
        let cached = await getCachedVenues(cache: cache)
        Task { try? await fetchAndCache(fetch: fetch, cache: cache) }
        return cached.isEmpty ? try await fetchAndCache(fetch: fetch, cache: cache) : cached
        
    case .cacheElseFetch:
        let cached = await getCachedVenues(cache: cache)
        return cached.isEmpty ? try await fetchAndCache(fetch: fetch, cache: cache) : cached
        
    case .networkOnly:
        return try await fetchAndCache(fetch: fetch, cache: cache)
        
    case .cacheOnly:
        let cached = await getCachedVenues(cache: cache)
        guard !cached.isEmpty else { throw VenueDataSourceError.noCachedData }
        return cached
        
    case .networkElseCache:
        do {
            return try await fetchAndCache(fetch: fetch, cache: cache)
        } catch {
            let cached = await getCachedVenues(cache: cache)
            guard !cached.isEmpty else { throw error }
            return cached
        }
    }
}

private let indexId = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"

private func fetchAndCache(
    fetch: () async throws -> [Venue],
    cache: TieredCache
) async throws -> [Venue] {
    let venues = try await fetch()
    for venue in venues { await cache.set(venue, expiresIn: 3600) }

    // Write an index venue whose name holds a comma-separated list of venue IDs
    if let first = venues.first {
        let ids = venues.map(\.cacheId).joined(separator: ",")
        let index = Venue(
            id: UUID(uuidString: indexId)!,
            name: ids,
            location: first.location,
            categories: [],
            rating: 0,
            distance: 0
        )
        await cache.set(index, expiresIn: 3600)
    }

    return venues
}

private func getCachedVenues(cache: TieredCache) async -> [Venue] {
    guard let indexVenue = await cache.getValue(
        Venue.self,
        id: UUID(uuidString: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF")!.uuidString
    ) else { return [] }
    
    var cached: [Venue] = []
    for id in indexVenue.name.split(separator: ",").map(String.init) {
        if let venue = await cache.getValue(Venue.self, id: id) { cached.append(venue) }
    }
    return cached
}

// MARK: - Errors

enum VenueDataSourceError: Error, LocalizedError {
    case bundleResourceNotFound(String)
    case noCachedData
    
    var errorDescription: String? {
        switch self {
        case .bundleResourceNotFound(let name): "Could not find \(name) in the app bundle."
        case .noCachedData: "No cached data available."
        }
    }
}
