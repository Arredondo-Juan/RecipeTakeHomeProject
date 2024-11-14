//
//  ParsingDataTest.swift
//  RecipeTakeHomeProjectTests
//
//  Created by Juan Arredondo on 11/13/24.
//

import XCTest
@testable import RecipeTakeHomeProject

final class ParsingDataTest: XCTestCase {

    func testRecipeDecoding() throws {
        // Mock JSON data
        let jsonData = """
        {
            "cuisine": "American",
            "name": "Burger",
            "photo_url_large": "https://example.com/burger.jpg",
            "source_url": "https://example.com/recipe"
        }
        """.data(using: .utf8)!
        
        // Decode JSON
        let recipe = try JSONDecoder().decode(Recipe.self, from: jsonData)
        
        // Verify the properties of the Recipe
        XCTAssertEqual(recipe.cuisine, "American")
        XCTAssertEqual(recipe.name, "Burger")
        XCTAssertEqual(recipe.photo_url_large, "https://example.com/burger.jpg")
        XCTAssertEqual(recipe.source_url, "https://example.com/recipe")
    }
}
