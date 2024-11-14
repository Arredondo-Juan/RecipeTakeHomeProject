//
//  LoadingRecipesTest.swift
//  RecipeTakeHomeProjectTests
//
//  Created by Juan Arredondo on 11/13/24.
//

import XCTest
@testable import RecipeTakeHomeProject

final class LoadingRecipesTest: XCTestCase {
    
    var contentView: ContentView!
    
    override func setUpWithError() throws {
        contentView = ContentView()
    }
    
    func testMalformedData() async throws {
        // Simulate loading from the malformed data endpoint
        let malformedURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        
        // Load recipes from the malformed URL
        contentView.loadRecipes(from: malformedURL)
             
        // Make sure that no recipes load
        XCTAssertTrue(contentView.recipes.isEmpty)
    }
    
    func testEmptyData() async throws {
        // Simulate loading from the empty data endpoint
        let emptyURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        
        // Load recipes from the empty URL
        contentView.loadRecipes(from: emptyURL)
        
        // Make sure that recipes are empty
        XCTAssertTrue(contentView.recipes.isEmpty) // Ensure recipes are empty
    }
    
}
