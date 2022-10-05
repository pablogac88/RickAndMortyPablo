//
//  CharactersModel.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//

import Foundation

struct CharactersModel {
    let idCharacter: Int
    let name: String
    let image: String
    let lastLocation: String
    let originLocation: String
    let locationId: String
    let status: String
    let specie: String
    var isFavourite: Bool = false
}
