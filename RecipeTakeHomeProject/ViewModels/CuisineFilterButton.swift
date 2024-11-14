//
//  CuisineFilterButton.swift
//  RecipeTakeHomeProject
//
//  Created by Juan Arredondo on 11/13/24.
//

import SwiftUI

struct CuisineFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(20)
        }
    }
}

#Preview {
    CuisineFilterButton(title: "American", isSelected: true) {}
}
