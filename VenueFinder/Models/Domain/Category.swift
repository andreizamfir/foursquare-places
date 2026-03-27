//
//  Category.swift
//  VenueFinder
//
//  Created by Andrei Zamfir on 26.03.2026.
//
import Foundation

public struct Category: DomainModel, Identifiable {
    public let id: UUID
    public let name: String
    public let icon: Icon
}
