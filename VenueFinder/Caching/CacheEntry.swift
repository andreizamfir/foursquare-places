//
//  CacheEntry.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 01.04.2026.
//
import Foundation

/// Wrapper that adds metadata to cached items.
/// Tracks when the item was cached and when it expires.
public struct CacheEntry<T: Cacheable>: Codable {
    public let value: T
    public let cachedAt: Date
    public let expiresAt: Date?

    public init(value: T, cachedAt: Date = Date(), expiresAt: Date? = nil) {
        self.value = value
        self.cachedAt = cachedAt
        self.expiresAt = expiresAt
    }

    /// Whether this entry has passed its expiration date.
    public var isExpired: Bool {
        guard let expiresAt else { return false }
        return Date() > expiresAt
    }

    /// How long ago this item was cached, in seconds.
    public var age: TimeInterval {
        Date().timeIntervalSince(cachedAt)
    }
}
