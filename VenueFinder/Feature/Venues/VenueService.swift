//
//  VenueDataSource.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

struct VenueService {
    var fetchVenues: () async throws -> [Venue]
}

extension VenueService {
    static func live() -> VenueService {
        VenueService {
            guard let url = Bundle.main.url(forResource: "venues", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                throw VenueDataSourceError.bundleResourceNotFound("venues.json")
            }
            
            let response = try JSONDecoder().decode(VenuesResponse.self, from: data)
            return response.venues.compactMap { $0.domainModel }
        }
    }

    static func mock(_ venues: [Venue] = .previews) -> VenueService {
        VenueService {
            try await Task.sleep(for: .milliseconds(500))
            return venues
        }
    }
    
    static func preview(_ venues: [Venue] = .previews) -> VenueService {
        VenueService { venues }
    }
    
    static func unimplemented() -> VenueService {
        VenueService {
            fatalError("Data source not implemented")
        }
    }
}

enum VenueDataSourceError: Error, LocalizedError {
    case bundleResourceNotFound(String)

    var errorDescription: String? {
        switch self {
        case .bundleResourceNotFound(let name):
            "Could not find \(name) in the app bundle."
        }
    }
}
