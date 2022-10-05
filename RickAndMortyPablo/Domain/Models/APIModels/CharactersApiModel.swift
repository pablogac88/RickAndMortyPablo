//
//  Response.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//

// MARK: - ResponseData
struct CharactersApiModel: Codable {
    let info: Info
    let characters: [Character]
    
    private enum CodingKeys: String, CodingKey {
        case info
        case characters = "results"
    }
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
    
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
