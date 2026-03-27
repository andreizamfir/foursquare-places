//
//  Location.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 26.03.2026.
//

public struct Location: DomainModel {
    public let address: String
    public let country: String
    public let locality: String
    public let postcode: String
    public let region: String
}
