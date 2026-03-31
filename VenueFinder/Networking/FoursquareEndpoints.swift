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
    static let apiVersion = "2025-06-17"

    /// Build a search places URL.
    static func searchPlaces(
        latitude: Double,
        longitude: Double,
        query: String? = nil,
        radius: Int = 5000,
        limit: Int = 10,
        apiKey: String
    ) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent("/places/search"), resolvingAgainstBaseURL: true)!

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "radius", value: String(radius)),
            URLQueryItem(name: "limit", value: String(min(limit, 50))),
            URLQueryItem(name: "oauth_token", value: apiKey)
        ]

        if let query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }

        components.queryItems = queryItems
        return components.url!
    }

    /// Build a search by bounds URL.
    static func searchPlacesByBounds(
        northeast: (latitude: Double, longitude: Double),
        southwest: (latitude: Double, longitude: Double),
        query: String? = nil,
        limit: Int = 10,
        apiKey: String
    ) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent("/places/search"), resolvingAgainstBaseURL: true)!

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ne", value: "\(northeast.latitude),\(northeast.longitude)"),
            URLQueryItem(name: "sw", value: "\(southwest.latitude),\(southwest.longitude)"),
            URLQueryItem(name: "limit", value: String(min(limit, 50))),
            URLQueryItem(name: "oauth_token", value: apiKey)
        ]

        if let query {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }

        components.queryItems = queryItems
        return components.url!
    }
}
