//
//  ContentView.swift
//  RecipeTakeHomeProject
//
//  Created by Juan Arredondo on 11/13/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State var recipes: [Recipe] = []
    @State private var isLoading: Bool = false
    @State private var selectedCuisine: String = "All"
    @State var errorMessage: String? = nil
    
    var cuisineTypes: [String] {
        let allCuisines = recipes.map { $0.cuisine }
        let uniqueCuisines = Set(allCuisines)
        return ["All"] + uniqueCuisines.sorted()
    }
    
    var filteredRecipes: [Recipe] {
        if selectedCuisine == "All" {
            return recipes
        }
        return recipes.filter { $0.cuisine == selectedCuisine }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                if !isLoading && errorMessage == nil && !filteredRecipes.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(cuisineTypes, id: \.self) { cuisine in
                                CuisineFilterButton(
                                    title: cuisine,
                                    isSelected: selectedCuisine == cuisine
                                ) {
                                    selectedCuisine = cuisine
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    }
                    .background(Color(.systemBackground))
                }
                
                if isLoading {
                    ProgressView("Loading recipes...")
                } else if let errorMessage = errorMessage {
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                        Button(action: reloadRecipes) {
                            Text("Try Again")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                } else if filteredRecipes.isEmpty {
                    VStack {
                        Text("No recipes available.")
                            .foregroundColor(.gray)
                            .padding()
                        Button(action: reloadRecipes) {
                            Text("Try Again")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredRecipes) { recipe in
                                RecipeCard(recipe: recipe)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear(perform: loadRecipesWrapper)
    }
    
    func reloadRecipes() {
        loadRecipes()
    }
    
    func loadRecipesWrapper() {
        loadRecipes()
    }
    
    func loadRecipes(from url: URL? = nil) {
        isLoading = true
        errorMessage = nil
        let recipeURL = url ?? URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        
        URLSession.shared.dataTask(with: recipeURL) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
                    self.isLoading = false
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                    self.isLoading = false
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode([String: [Recipe]].self, from: data)
                DispatchQueue.main.async {
                    self.recipes = decodedResponse["recipes"] ?? []
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Malformed data received."
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
