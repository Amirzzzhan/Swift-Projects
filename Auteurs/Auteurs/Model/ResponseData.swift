//
//  Auteurs.swift
//  Auteurs
//
//  Created by Amirzhan Armandiyev on 20.11.2022.
//

import Foundation

struct ResponseData: Codable {
    let auteurs: [Auteurs]
}

struct Auteurs: Codable {
    let name: String
    let bio: String
    let image: String
    let source: String
    let films: [Films]
}

struct Films: Codable {
    let title: String
    let year: String
    let poster: String
    let plot: String
    var isExpanded: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        poster = try container.decode(String.self, forKey: .poster)
        plot = try container.decode(String.self, forKey: .plot)
        isExpanded = false
    }
}
