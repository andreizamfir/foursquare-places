//
//  Array+Cacheable.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 01.04.2026.
//

/// Arrays of Cacheable items are themselves Cacheable.
/// Useful for caching list responses.
extension Array: Cacheable where Element: Cacheable {
    public var cacheId: String {
        Self.cacheIdentifier
    }
    
    public static var cacheIdentifier: String {
        "\(Element.cacheIdentifier)-array"
    }
    
}
