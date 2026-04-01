//
//  Cacheable.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 01.04.2026.
//

/// Types that can be stored in a cache.
/// Requires an identifier for retrieval and a type identifier for organization.
public protocol Cacheable: Codable {
    /// Unique identifier for this item within its type.
    var cacheId: String { get }

    /// Identifier for this type of cached item.
    /// Used to organize cache storage by type.
    static var cacheIdentifier: String { get }
}
