//
//  Recipe.swift
//  RecipeTakeHomeProject
//
//  Created by Juan Arredondo on 11/13/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let cuisine: String
    let name: String
    let photo_url_large: String
    let source_url: String?
    
    enum CodingKeys: CodingKey {
        case cuisine, name, photo_url_large, source_url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photo_url_large = try container.decode(String.self, forKey: .photo_url_large)
        self.source_url = try? container.decode(String.self, forKey: .source_url)
    }
}
