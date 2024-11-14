//
//  RecipeCard.swift
//  RecipeTakeHomeProject
//
//  Created by Juan Arredondo on 11/13/24.
//

import SwiftUI
import Kingfisher

struct RecipeCard: View {
    let recipe: Recipe
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(URL(string: recipe.photo_url_large))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 160)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            
            if let sourceUrl = recipe.source_url {
                VStack {
                    Button(action: {
                        if let url = URL(string: sourceUrl) {
                            openURL(url)
                        }
                    }) {
                        VStack(spacing: 4) {
                            Image(systemName: "globe")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            
                            Text("Source")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .cornerRadius(16)
        .shadow(radius: 2, y: 1)
    }
}
