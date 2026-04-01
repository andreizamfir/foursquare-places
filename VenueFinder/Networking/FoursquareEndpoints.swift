//
//  FoursquareEndpoints.swift
//  VenueFinder
//
//  Created by Claude on 29.03.2026.
//

import Foundation

/// Foursquare Places API endpoint helpers.
enum FoursquareEndpoints {
    static let baseURL = URL(string: "https://places-api.foursquare.com")!

    /// Build a search places URL.
    static func searchPlaces(
        latitude: Double,
        longitude: Double,
        query: String? = nil,
        radius: Int = 5000,
        limit: Int = 10
    ) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent("/places/search"), resolvingAgainstBaseURL: true)!

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "radius", value: String(radius)),
            URLQueryItem(name: "limit", value: String(min(limit, 50)))
        ]

        if let query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }

        components.queryItems = queryItems
        return components.url!
    }
}
