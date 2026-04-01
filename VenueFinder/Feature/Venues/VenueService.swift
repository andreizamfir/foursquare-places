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
    
    static func live(apiKey: String = "RSGW01XR1Y1CAYG04EM3BP1EM0TXGDGSMCF11AKMKYZSDPOR") -> VenueService {
        VenueService {
            let client = HTTPClient.live(apiKey: apiKey)
            let response = try await client.decode(
                VenuesApiResponse.self,
                from: FoursquareEndpoints.searchPlaces(
                    latitude: 40.7,
                    longitude: -74.0
                )
            )

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
    
    static func json() -> VenueService {
        VenueService {
            guard let url = Bundle.main.url(forResource: "venues", withExtension: "json"),
                  let data = try? Data(contentsOf: url)
            else {
                throw VenueDataSourceError.bundleResourceNotFound("venues.json")
            }

            let response = try JSONDecoder().decode(VenuesApiResponse.self, from: data)
            return response.venues.compactMap { $0.domainModel }
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
