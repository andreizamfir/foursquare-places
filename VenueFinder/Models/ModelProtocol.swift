//
//  ModelProtocol.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 26.03.2026.
//

public protocol ApiModel: Codable, Hashable, Sendable, Equatable {}

public protocol DomainModel: Codable, Equatable, Hashable, Sendable {}
