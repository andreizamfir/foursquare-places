//
//  VenueFinderTests.swift
//  VenueFinderTests
//
//  Created by Andrei Zamfir on 13.03.2026.
//

import Testing
import XCTest
import Foundation

struct VenueFinderTests {
    
    @Test func testDisplayTitle() {
        let venue = Venue.preview

        XCTAssertEqual(venue.displayTitle, "Sample Venue, 1.5 km away")
    }
    
    @Test func testMappingFiltersMissingName() {
        let apiModel = VenueApiModel(id: "",
                                     name: nil,
                                     location: nil,
                                     categories: nil,
                                     rating: nil,
                                     distance: nil)
        
        XCTAssertNil(apiModel.domainModel)
    }

}
