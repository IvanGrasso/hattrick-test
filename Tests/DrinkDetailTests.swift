//
//  DrinkDetailTests.swift
//  Tests
//
//  Created by Ivan Grasso on 17/08/2021.
//

import XCTest
@testable import HattrickChallenge

class DrinkDetailTests: XCTestCase {
    
    func test_GivenExpectedResponseJSON_WhenDecoding_ThenModelIsCreatedCorrectly() throws {
        // Given
        let bundle = Bundle(for: DrinkDetailTests.self)
        let fileURL = try XCTUnwrap(bundle.url(forResource: "DrinkDetailResponse", withExtension: "json"))
        let data = try Data(contentsOf: fileURL)
        
        // When
        let response = try JSONDecoder().decode(DrinkDetailResponse.self, from: data)
        
        // Then
        let sut = try XCTUnwrap(response.drinks.first)
        
        XCTAssertEqual(sut.name, "9 1/2 Weeks")
        XCTAssertEqual(sut.instructions, "Combine all ingredients in glass mixer. Chill and strain into Cocktail glass. Garnish with sliced strawberry.")
        XCTAssertEqual(sut.thumbnail, "https://www.thecocktaildb.com/images/media/drink/xvwusr1472669302.jpg")
        
        let expectedIngredients = [
            "Absolut Citron",
            "Orange Curacao",
            "Strawberry liqueur",
            "Orange juice"
        ]
        XCTAssertEqual(sut.ingredients, expectedIngredients)
        
        let expectedMeasures = [
            "2 oz ",
            "1/2 oz ",
            "1 splash ",
            "1 oz "
        ]
        XCTAssertEqual(sut.measures, expectedMeasures)
    }

}
