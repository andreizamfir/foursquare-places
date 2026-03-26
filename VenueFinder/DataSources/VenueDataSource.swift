//
//  VenueDataSource.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 13.03.2026.
//
import SwiftUI

struct VenueDataSource {
    var fetchVenues: () async throws -> [Venue]
}

extension VenueDataSource {
    static func live() -> VenueDataSource {
        VenueDataSource {
            guard let url = Bundle.main.url(forResource: "venues", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                throw VenueDataSourceError.bundleResourceNotFound("venues.json")
            }
            
            let response = try JSONDecoder().decode(VenuesResponse.self, from: data)
            return response.venues
        }
    }

    static func mock(_ venues: [Venue] = .previews) -> VenueDataSource {
        VenueDataSource { venues }
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
